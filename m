From: Francois-Xavier Le Bail <devel.fx.lebail@orange.fr>
Subject: Re: How to rebase when some commit hashes are in some commit messages
Date: Thu, 15 Oct 2015 10:06:11 +0200
Message-ID: <561F5E73.3050506@orange.fr>
References: <561C1132.3090606@orange.fr> <vpqsi5fx2gr.fsf@grenoble-inp.fr> <561CC5E0.7060206@orange.fr> <20151013160004.11a103942062ee09c53bd235@domain007.com> <AD64941D9533442AB025BE27FF8F08AF@PhilipOakley> <CA+P7+xoDia6PC+qJeVn3sD5g4jk7KRuDAPOcEHvrntd+ndUraA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 10:06:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmdYk-00086x-1i
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 10:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbbJOIGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 04:06:17 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:37675 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbbJOIGO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 04:06:14 -0400
Received: from [127.0.0.1] ([213.178.77.178])
	by mwinf5d29 with ME
	id VL6B1r00F3qpEb103L6Bxo; Thu, 15 Oct 2015 10:06:12 +0200
X-ME-Helo: [127.0.0.1]
X-ME-Auth: ZGV2ZWwuZngubGViYWlsQHdhbmFkb28uZnI=
X-ME-Date: Thu, 15 Oct 2015 10:06:12 +0200
X-ME-IP: 213.178.77.178
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CA+P7+xoDia6PC+qJeVn3sD5g4jk7KRuDAPOcEHvrntd+ndUraA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279651>



On 13/10/2015 19:07, Jacob Keller wrote:

> b) you are rebasing a commit which references another commit in the same rebase
> 
> I see no valid reason to reference a sha1 in this case. If you're
> referencing as a "fixes", then you are being silly since you can just
> squash the fix into the original commit and thus prevent introduction
> of bug at all.

squash need manual process, renaming the sha1 not.
