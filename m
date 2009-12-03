From: Uri Okrent <uokrent@gmail.com>
Subject: Re: Git documentation consistency
Date: Thu, 3 Dec 2009 07:24:30 -0800
Message-ID: <6839293b0912030724y1c794606w3f2b191b3123a542@mail.gmail.com>
References: <m1NEaLp-000kn1C@most.weird.com>
	 <20091129051427.GA6104@coredump.intra.peff.net>
	 <m1NFAji-000kn2C@most.weird.com>
	 <20091202200904.GA7631@coredump.intra.peff.net>
	 <m1NG0O6-000kmgC@most.weird.com>
	 <7vaay096ye.fsf@alter.siamese.dyndns.org>
	 <m1NG61U-000kn4C@most.weird.com>
	 <20091203074500.GA31566@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: The Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 03 16:24:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGDXo-00087n-JP
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 16:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104AbZLCPYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 10:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756078AbZLCPYZ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 10:24:25 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:63546 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbZLCPYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 10:24:24 -0500
Received: by pwi3 with SMTP id 3so1170872pwi.21
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 07:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=HvsEf6wpt0dgfL5KZLgfjJl4K/7/FC4upp/lYLO8NCA=;
        b=KXNkC7hCZMVc/2t2CJT8K9/+aJAznFln9lTxn+o9g9bwLoCMsoC1Jy+cmwESGFR/K4
         HdO67B9B2szo2HyBt7coatzbD3XT3XD++Ud/DbY9HJU1FcTSBZKwFLSOcF5Gm5YKfsEa
         M8Eh1vnYd81aqDrZcHcB3GAqd/FMXxV8s5LII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KPLw8WZ5haiRIgD7MIY/9bhH4vZLnf7KNswocsTiolEakiV43848+k9ibIZkgxDtl9
         C9mdHfB3VF7DNkmo7HgBYZnUy5XRQ0qQwMx2UlC5xqt1X05cgQmg4ojGWj1ZFAnaqI7o
         Byr/artdxFTQsykPvs+HU5EfO1XKX4ToY50Sk=
Received: by 10.140.132.9 with SMTP id f9mr119424rvd.234.1259853870451; Thu, 
	03 Dec 2009 07:24:30 -0800 (PST)
In-Reply-To: <20091203074500.GA31566@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134455>

On Wed, Dec 2, 2009 at 11:45 PM, Jeff King <peff@peff.net> wrote:
> So what systems _do_ treat "-?" specially?
>
> -Peff

Windows seems to (of course you need to use '/' instead of '-'):

Microsoft Windows [Version 6.0.6001]

c:\>dir -h
 Volume in drive C has no label.
 Volume Serial Number is B09A-B49F

 Directory of c:\

File Not Found

c:\>dir /h
Invalid switch - "h".

c:\>dir /help
Invalid switch - "help".

c:\>dir /?
Displays a list of files and subdirectories in a directory.

DIR [drive:][path][filename] [/A[[:]attributes]] [/B] [/C] [/D] [/L] [/N]
  [/O[[:]sortorder]] [/P] [/Q] [/R] [/S] [/T[[:]timefield]] [/W] [/X] [/4]

  [drive:][path][filename]
              Specifies drive, directory, and/or files to list.

  /A          Displays files with specified attributes.
  attributes   D  Directories                R  Read-only files
               H  Hidden files               A  Files ready for archiving
               S  System files               I  Not content indexed files
               L  Reparse Points             -  Prefix meaning not
  /B          Uses bare format (no heading information or summary).
  /C          Display the thousand separator in file sizes.  This is the
              default.  Use /-C to disable display of separator.
  /D          Same as wide but files are list sorted by column.
  /L          Uses lowercase.
  /N          New long list format where filenames are on the far right.
  /O          List by files in sorted order.
  sortorder    N  By name (alphabetic)       S  By size (smallest first)
               E  By extension (alphabetic)  D  By date/time (oldest first)
               G  Group directories first    -  Prefix to reverse order
  /P          Pauses after each screenful of information.
  /Q          Display the owner of the file.
  /R          Display alternate data streams of the file.
  /S          Displays files in specified directory and all subdirectories.
  /T          Controls which time field displayed or used for sorting
  timefield   C  Creation
              A  Last Access
              W  Last Written
  /W          Uses wide list format.
  /X          This displays the short names generated for non-8dot3 file
              names.  The format is that of /N with the short name inserted
              before the long name. If no short name is present, blanks are
              displayed in its place.
  /4          Displays four-digit years

Switches may be preset in the DIRCMD environment variable.  Override
preset switches by prefixing any switch with - (hyphen)--for example, /-W.

c:\>

-- 
   Uri

Please consider the environment before printing this message.
http://www.panda.org/how_you_can_help/
