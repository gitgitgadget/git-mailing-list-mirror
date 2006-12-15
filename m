X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 23:48:16 +0100
Message-ID: <200612152348.17997.jnareb@gmail.com>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <eluhk3$pv7$1@sea.gmane.org> <7vhcvwomde.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 22:46:01 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HlBPkxACMsJmKadaG+PwJaz5XJvMCXKNxM8C0dyagNyd0mQjcI+JvjV47IFEt6NDZXRNC9nBhCR7u3geiooTTI4lWS5SnXh36LSsxBrTFgwFDZsRXSmb4fJR6K0eFhKDCDKRYXcLF3Wt0G1Dape0GVaTyvLOYHIL5VRfvCTD6QA=
User-Agent: KMail/1.9.3
In-Reply-To: <7vhcvwomde.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34569>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvLoS-0004SP-0U for gcvg-git@gmane.org; Fri, 15 Dec
 2006 23:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030302AbWLOWpx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 17:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWLOWpx
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 17:45:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:12435 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1030302AbWLOWpw (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 17:45:52 -0500
Received: by ug-out-1314.google.com with SMTP id 44so940670uga for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 14:45:50 -0800 (PST)
Received: by 10.66.243.2 with SMTP id q2mr2149984ugh.1166222750668; Fri, 15
 Dec 2006 14:45:50 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id q40sm5068716ugc.2006.12.15.14.45.47; Fri, 15 Dec
 2006 14:45:50 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Shawn Pearce wrote:
>>
>>> Andy Parkins <andyparkins@gmail.com> wrote:
>>>>  * git-show-branch output is cryptic.
>>> 
>>> Agreed.  I still don't know how to read its output.  So I just
>>> don't use it.  Ever.  :-)
>>
>> And the way it uses it's options is even more cryptic, and differs from
>> other similar commands.
> 
> (Jakub, please do not drop people from cc: list; you were asked
> more than once).

The problem is that I'm not subscribed to git mailing list; I usually
read it via GMane news<->mail interface, at
  nntp://news.gmane.org/gmane.comp.version-control.git
First, in this interface I have only the last author and not the full
Cc: list. Second, when I reply _both_ via email (adding authors if
necessary) and to news, people receiving my reply don't have (I guess)
git@vger.kernel.org in Cc: list, so sometimes the discussion drops off
the list. Third, if I add git mailing list address when replying via
mail, vger server blocks email from gmane stating

  Technical details of permanent failure:
  PERM_FAILURE: SMTP Error (state 9): 501 5.1.3 Path data: Had characters unsuitable for an rfc821-string

When email is sent _directly_ to me (i.e. I'm on Cc: list) I try
to preserve Cc: list.

> Ok, so what's the action you guys are proposing?
> 
>  (1) show-branch input is cryptic and it does not do anything
>      useful.  Drop it.
> 
>  (2) show-branch input is cryptic and I do not understand what
>      it is trying to do.  Document it better.
[...]

I'm just used to the way revisions are specified to other history
viewers: git-log (via git-rev-list), gitk, qgit. git-show-branch
is a bit odd man out here. "git-show-branch ref1 ref2 ref3"
is (without --more=n) like 

  git rev-list ref1 ref2 ref3 --not $(git merge-base ref1 ref2 ref3)

Which is handy for git-show-branch, but odd. Perhaps we should add
--xor option to git rev list for the above, i.e.

  git rev-list A...B        == 
    == git rev-list A B --not $(git merge-base A B)
  git rev-list --xor A B C  ==
    == git rev-list A B C --not $(git merge-base A B C)   
 
> Personally, I find its input branch globbing very handy, and
> often wish that 'git branch' had a '--list' option that lists
> branches that match the glob pattern given on the command line,
> not just listing everything when no parameter is given.
 
It is odd (git branch not having --list with globbing) also because
'git tag' has globbing support.

-- 
Jakub Narebski
