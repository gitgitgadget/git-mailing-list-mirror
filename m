From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch submodules
 too
Date: Thu, 14 Oct 2010 20:14:50 +0200
Message-ID: <4CB7489A.60903@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de> <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org> <4CB0BFDB.7010503@web.de> <4CB5C6D8.1070108@xiplink.com> <4CB6093F.3040800@web.de> <1691DBFD-6075-479E-8847-EB4595BB9E10@sb.org> <4CB61137.6030502@web.de> <4CB65650.6080204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 20:15:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6SKU-0006nf-4j
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 20:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab0JNSO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 14:14:56 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:50693 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab0JNSOz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 14:14:55 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id BDF9816F0332F;
	Thu, 14 Oct 2010 20:14:53 +0200 (CEST)
Received: from [93.240.120.140] (helo=[192.168.178.29])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P6SKL-0000XG-00; Thu, 14 Oct 2010 20:14:53 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <4CB65650.6080204@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX190SYXSy7KTcNdtDqoMVmsXiKMABxQA3hS4hAeW
	uBflRYxCva8x7Ve4wLuEp2t1wcRUT0mXMXG55Xu54WMdFuMZ7W
	daBtCzbsdGPW8EKJmjkQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159062>

Am 14.10.2010 03:01, schrieb Chris Packham:
> For modules they are working on they to rebase their working branch to
> the SHA1 recorded in the superproject. I think this kind of thing has
> already been discussed on the list, not sure that I've seen a solution
> that would work for us. For now all of this is is wrapped in a script
> for the developers.

I assume you know the "--rebase" option and the "update=rebase" config
setting for "git submodule update" and they don't work for you?


> Developers would probably want the fetch-if-super-gitlink-has-changed
> behaviour.

Yeah, I think we need to support the fetch-if-super-gitlink-has-changed,
always-fetch-all and never-fetch behavior. So in your example you could
set fetch-if-super-gitlink-has-changed in the global config and use
fetch-all for the submodule you are hacking on by changing its config
if you want that.


> Hope that is a useful use-case.

Sure, thanks!
