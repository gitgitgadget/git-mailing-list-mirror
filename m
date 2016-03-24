From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 2/2] completion: add 'revisions' and 'everyday' to 'git help'
Date: Thu, 24 Mar 2016 20:51:04 -0000
Organization: OPDS
Message-ID: <B40A8BBB3787424787785220EA6BFCFE@PhilipOakley>
References: <1458844034-12855-1-git-send-email-ralf.thielow@gmail.com><1458844034-12855-3-git-send-email-ralf.thielow@gmail.com> <xmqq7fgr8wqc.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Ralf Thielow" <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 21:51:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajCDt-0004Rb-Dk
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 21:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbcCXUvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 16:51:07 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:53294 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbcCXUvG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 16:51:06 -0400
Received: from PhilipOakley ([92.22.6.252])
	by smtp.talktalk.net with SMTP
	id jCDdabZl8CrtejCDea9lcl; Thu, 24 Mar 2016 20:51:03 +0000
X-Originating-IP: [92.22.6.252]
X-Spam: 0
X-OAuthority: v=2.1 cv=L/e9O7n8 c=1 sm=1 tr=0 a=L1JPMP/96Cd0ZXeOJ41CKA==:117
 a=L1JPMP/96Cd0ZXeOJ41CKA==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=sgMr-s8sPSwgmRqELakA:9 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfDE+Kgw2p4/bOqHiq9wuU14uSc5lVn1zMj8oBXltsvFpSiyH4zvSF1yKhdLFVoq0rL9uES3QsYRp1PGsSJCz2f5L+n8dfwbxuJZDP9dCe6XlviYw9sj5
 dBHgRUCGC1cAG2Nv79XC1GN51SS1USnYw8aJkNYntXrNhTPkkHoqt9d1Vi0ZoYi/dxWLMce9JUVAje07ibdRsJxTUlojKEvhVIJ7M2euqY6C/xnSX3i5aT4r
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289796>

From: "Junio C Hamano" <gitster@pobox.com>
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> It is somewhat silly that we have to maintain this list to be in
> sync with the set of documents we offer.  Wouldn't it make more
> sense to go in the direction of _removing_ this list of hardcoded
> words here?
>
> The first step may be to teach a new subcommand to "git help"
> to show a list of these words, and then _git_help can use it to
> lazily compute the list just like __git_commands does.

'git help -a' (or --all) already determines the list of commands available, 
but then formats it prettily for user consumption. Maybe an alternate --list 
option?

>
> But this change itself is not wrong per-se; will queue to see where
> follow-up discussion will lead us to.
>
> Thanks.
>
>
>> diff --git a/contrib/completion/git-completion.bash 
>> b/contrib/completion/git-completion.bash
>> index 70f4171..ffe6004 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1346,8 +1346,8 @@ _git_help ()
>>  __git_compute_all_commands
>>  __gitcomp "$__git_all_commands $(__git_aliases)
>>  attributes cli core-tutorial cvs-migration
>> - diffcore gitk glossary hooks ignore modules
>> - namespaces repository-layout tutorial tutorial-2
>> + diffcore everyday gitk glossary hooks ignore modules
>> + namespaces repository-layout revisions tutorial tutorial-2
>>  workflows
>>  "
>>  }
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
