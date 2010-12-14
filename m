From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 14 Dec 2010 08:23:12 +0100
Message-ID: <4D071B60.2040906@viscovery.net>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org> <7vlk01hqzz.fsf@gitster.siamese.dyndns.org> <20080718175040.6117@nanako3.lavabit.com> <20080718182010.6117@nanako3.lavabit.com> <20080718094404.GB32184@machine.or.cz> <7vtzen7bul.fsf@gitster.siamese.dyndns.org> <loom.20101213T194818-377@post.gmane.org> <7vbp4pz9hf.fsf@alter.siamese.dyndns.org> <20101213214628.GA13447@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 08:23:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSPEM-000352-Nb
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 08:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab0LNHXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 02:23:18 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:55821 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754989Ab0LNHXS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 02:23:18 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PSPE9-0001lU-36; Tue, 14 Dec 2010 08:23:13 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CD4191660F;
	Tue, 14 Dec 2010 08:23:12 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101213214628.GA13447@onerussian.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163631>

Am 12/13/2010 22:46, schrieb Yaroslav Halchenko:
> On Mon, 13 Dec 2010, Junio C Hamano wrote:
>> But for such a use case, "git read-tree -m -u 0.2" would work just as
>> well, and discussion ended there ;-)
> 
> hm -- read-tree sounded like yet another unknown to me feature of GIT I
> was trying desperately to discover ;)  unfortunately it doesn't produce a merge
> for me :-/ -- just a simple commit with the state taken from the other tree:

How about:

  git merge --no-commit -s ours 0.2
  git read-tree -m -u 0.2
  git commit -m "Reset to 0.2"

-- Hannes
