From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/8] Docs: send-email: Man page option ordering
Date: Mon, 29 Sep 2008 02:10:31 +0200
Message-ID: <200809290210.33880.jnareb@gmail.com>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu> <gbne1a$8g2$1@ger.gmane.org> <FB3A852B-728F-4183-A5AF-BA8F8D995AD7@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 29 02:11:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kk6Mo-0006zY-D5
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 02:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbYI2AKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 20:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbYI2AKo
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 20:10:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:57271 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbYI2AKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 20:10:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1254508fgg.17
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 17:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ePS8ley8BOQHHfvJu68eEv7IKqqRY4ZgDGcPmUdAYWo=;
        b=QfKr2HlvY6ekTq/08zC4xMP0FkuwRVqSIHNnzfuL6sdCDEq6zZrwCIszd9dnlWPy2F
         e5CI/du6BNprTR5ZaME4iXFefM3aaR4GwyKYn1h+ILzxlOTEYSdwtgHSJgOrfrovfaha
         hpZ69lZGAbot7XF41LShhnhJEl9WDcjmn2rNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jUroLxAW6RO/UwBKDjjntvkbevsM+Et+K6dCplPe0J6KGQBS4CUITb1Fo0ocvjGpCW
         Txqh5P1EXA9ZrbNkUN+kDUF2vF6zverjSnJnOKeWQ7vSIpUir5KwAHRQk31J2cFiMI6/
         edrGTgPUPJczTr+rYJ2pK+kkg29Mbk196YUkQ=
Received: by 10.86.98.14 with SMTP id v14mr3628168fgb.74.1222647041615;
        Sun, 28 Sep 2008 17:10:41 -0700 (PDT)
Received: from ?192.168.1.11? (abvx193.neoplus.adsl.tpnet.pl [83.8.221.193])
        by mx.google.com with ESMTPS id 4sm2837674fgg.4.2008.09.28.17.10.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Sep 2008 17:10:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <FB3A852B-728F-4183-A5AF-BA8F8D995AD7@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96989>

On Sun, 28 Sep 2008 21:04, Michael Witten wrote:
> On 28 Sep 2008, at 3:08 AM, Jakub Narebski wrote:
>> Michael Witten wrote:
>>
>>> Now the man page lists the options in alphabetical
>>> order (in terms of the 'main' part of an option's
>>> name).
>>
>> I know it is a matter of taste, but I prefer having options
>> on man page in functional order, grouped by function, perhaps
>> with subsections to group them (c.f. git-rev-list man page).
> 
> See: http://marc.info/?l=git&m=122246885210923&w=2

You meant the following comment by  Jeff King?

peff>   4/6: I am not sure about making the order of options the same, 
peff>        the two formats serve different purposes. I think
peff>        "git send-email --foo" should present the options based on
peff>        commonality of use. You clearly got the usage wrong, so
peff>        I think it is helping you to figure out quickly what you
peff>        probably  meant. 

This agrees with Gnits (GNU Coding Standard expanded) about --help
http://www.gnu.org/software/womb/gnits/Help-Output.html#Help-Output

# When a program has many options, try regrouping options logically,
  instead of listing them all alphabetically (say), as the mere
  regrouping is a succint way to convey much information. Present each
  group of options in its own subtable, suitably introduced by some few
  words. Separate groups by white lines for making the overall structure
  more easy to grasp by the reader. Here is an excerpt from a relatively
  big `--help' output:

       Main operation mode:
          -t, --list              list the contents of an archive
          -x, --extract, --get    extract files from an archive
          -c, --create            create a new archive
          -d, --diff, --compare   find differences between archive and file system
          -r, --append            append files to the end of an archive
          -u, --update            only append files newer than copy in archive
          -A, --catenate          append tar files to an archive
              --concatenate       same as -A
              --delete            delete from the archive (not on mag tapes!)
          
        Device blocking:
          -b, --blocking-factor=BLOCKS   BLOCKS x 512 bytes per record
              --record-size=SIZE         SIZE bytes per record, multiple of 512
          -i, --ignore-zeros             ignore zeroed blocks in archive (means EOF)
          -B, --read-full-records        reblock as we read (for 4.2BSD pipes)


peff>    The manpage, on the other hand, is a comprehensive reference
peff>    and so should probably be alphabetized for easy reading.
 
I haven't found definitive guide or definitive suggestion whether
options in man page should be alphabetized or put in some functional
order. GNU Coding Standards doesn't say anything; at least I haven't
found anything on this topic.

First, git lacks structured texinfo documentation, so manpages serves
_both_ as reference, and _as learning tool_. For learning you would
want options grouped by function, perhaps sorted alphabetically in
group. If you want to find some option, you can always use search
and incremental search capabilities of manpages pager.

Second, large manpages with large number of options are usually divided
into sections, see git-rev-list(1) manpage, or rpmbuild(8) manpage. So
there is precedent for that. And I think it is good precedent.

-- 
Jakub Narebski
Poland
