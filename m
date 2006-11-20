X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Patch to tutorial.txt
Date: Mon, 20 Nov 2006 09:49:31 +0100
Message-ID: <200611200949.32722.jnareb@gmail.com>
References: <4d8e3fd30611191444r710f23e5uc488d35aa4abaf06@mail.gmail.com> <ejqnh8$peb$1@sea.gmane.org> <4d8e3fd30611200030p1d117445qd3f7d619c18a0633@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 08:48:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PLCSfpMofuC5G9Kwj0PVgtwLuC9cWumVgFfjjBnzS2BcSgQ1FZXHrCvpiXvKt0AQ+xFRdgWSUx8M6deNJIeEOkdZ+9Vm1BLMnxHVQXEQe7rZpZg5sErVMRwcTE3gvBbxMfoB493mPaZWOsrgrY2OtyKjJ0Z5fSxFvHq5HStjPZ4=
User-Agent: KMail/1.9.3
In-Reply-To: <4d8e3fd30611200030p1d117445qd3f7d619c18a0633@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31886>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm4p2-0006Qv-U7 for gcvg-git@gmane.org; Mon, 20 Nov
 2006 09:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934010AbWKTIsJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 03:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934013AbWKTIsJ
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 03:48:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:37026 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S934010AbWKTIsI
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 03:48:08 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1119034ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 00:48:07 -0800 (PST)
Received: by 10.67.100.17 with SMTP id c17mr7426026ugm.1164012486882; Mon, 20
 Nov 2006 00:48:06 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 24sm8046874ugf.2006.11.20.00.48.06; Mon, 20 Nov
 2006 00:48:06 -0800 (PST)
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Sender: git-owner@vger.kernel.org

On Mon, 20 Nov 2006, Paolo Ciarrocchi wrote:
> On 11/19/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> Paolo Ciarrocchi wrote:

>>> From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
>>> Date: Sun, 19 Nov 2006 23:41:31 +0100
>>> Subject: [PATCH] One of the comment was not really clear, rephrased to
>>> make it easier to be understood by the reader
>>
>> Wordwrap. Perhaps it would be better to split description into short line,
>> and two-line description.

See http://git.or.cz/gitwiki/CommitMessageConventions

In short, it is better to split description into short one-line
description, for example
  "Documentation: Make comment about merging in tutorial.txt more clear"
followed by empty line, then longer description of changes (if any), for
example

  One of the comment was not really clear, rephrased to make it easier
  to be understood by the reader

followed by empty line, then signoff line, for example

  Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>

> This is not clear to me, when I do a "git commit -a" I can add a text using vi,
> should I manually split the text in multiple lines?
> Only the first line will be part of the Subject?

Yes. The rest will be in the email body.
 
>> [...]
>>>  ------------------------------------------------
>>>
>>>  at this point the two branches have diverged, with different changes
>>> -made in each.  To merge the changes made in the two branches, run
>>> +made in each.  To merge the changes made in experimental into master run
>>
>> I would rather say:
>>   To merge the changes made in the two branches into master, run
> 
> Why Jakub? There are only two branches, master and experimental.
> While sitting in master and doing git pull . experimental I would
> expect to merge I did in experimental into master. Changes did in
> master are alreay merged in master. Am I wrong?

For me, "merge" in "to merge the changes" phrase is merge in common-sense
meaning of the world, not the SCM jargon. Merge the changes == join the
changes, so you have to give both sides, both changes you join.

Merge the changes == take changes in branch 'experimental' since forking,
take changes in branch 'master' since forking, join those changes
together (merge), and put the result of this joining (this merge) into
branch 'master'.

On the contrary, in "merge branch 'experimenta' into 'master'" phrase
"merge" is in the SCM meaning of this word.


Just my 2 eurocoents of not native English speaker...
-- 
Jakub Narebski
