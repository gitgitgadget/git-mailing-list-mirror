From: =?ISO-8859-1?Q?Andreas_Gr=FCnbacher?= <agruen@gnu.org>
Subject: GNU patch version 2.7 released
Date: Wed, 12 Sep 2012 16:22:26 +0200
Message-ID: <CAHpGcMKsLkyrxDBe8t2owdjtkk0dnpONRrQDDB9UcdctSK35jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, bug-diffutils@gnu.org
To: bug-patch@gnu.org
X-From: git-owner@vger.kernel.org Wed Sep 12 16:22:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBnpu-0006Qp-Et
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 16:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758891Ab2ILOW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 10:22:29 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:32789 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757612Ab2ILOW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 10:22:28 -0400
Received: by lbbgj3 with SMTP id gj3so1178808lbb.19
        for <git@vger.kernel.org>; Wed, 12 Sep 2012 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=MobATkDFdATVmm52/UlNNScNjqB+OYv1r1D9y9Ig9kU=;
        b=hCtJ5vqkF3ILt/9MNdIbYON89MevQCxPy4jXImoEcqwn9l2blQG8O2eL9FWMHsXELz
         pXwm0Lfe6aMm3dRZLs6PzAibx5FT/9wzz4TaoA2xuQ4J4bcgIdhcbz1ed+G0Aatdw0E9
         P0aCp2halcrMXrqS2lKY4ntnC9hpb8Pj6n0rRXqyCew8gcay5nHf4o6owoVyDoUMjp9G
         st3XzlGZQuK5v9DWPv6oXFqsB2gjJOBKR+z5tJ6UX3Hq6OklbfZtIm1Z0DyIcftq0Kea
         Hy6X6FkxG2y7+hSpeNEjq8hkUZ72WI4Z/q8Dq4pOKX1awqH3qd9NwQhSXuCiG/qDXqt4
         nu7g==
Received: by 10.112.30.34 with SMTP id p2mr7527499lbh.85.1347459746781; Wed,
 12 Sep 2012 07:22:26 -0700 (PDT)
Received: by 10.112.54.180 with HTTP; Wed, 12 Sep 2012 07:22:26 -0700 (PDT)
X-Google-Sender-Auth: 6he94XOzEmclUj_n9ldHneSi1D0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205298>

I am pleased to announce that version 2.7 of GNU patch has been
released. The following significant changes have happened since the
last stable release in December 2009:

* Support for most features of the "diff --git" format, including renames and
  copies, permission changes, and symlink diffs.  Binary diffs are not
  supported yet; patch will complain and skip them.

* Support for double-quoted filenames: when a filename starts with a double
  quote, it is interpreted as a C string literal.  The escape sequences \\, \",
  \a, \b, \f, \n, \r, \t, \v, and \ooo (a three-digit octal number between 0 and
  255) are recognized.

* Ignore destination file names that are absolute or that contain a component
  of "..".  This addresses CVE-2010-4651.

* Refuse to apply a normal patch to a symlink.  (Previous versions of patch
  were replacing the symlink with a regular file.)

* When trying to modify a read-only file, warn about the potential problem
  by default.  The --read-only command line option allows to change this
  behavior.

* Files to be deleted are deleted once the entire input has been processed, not
  immediately.  This fixes a bug with numbered backup files.

* When a timestamp specifies a time zone, honor that instead of assuming the
  local time zone (--set-date) or Universal Coordinated Time (--set-utc).

* Support for nanosecond precision timestamps.

* Patch no longer gets a failed assertion for certain mangled patches.

* Many portability and bug fixes.

Release tarballs are available at:

  ftp://ftp.gnu.org/gnu/patch/

Please report bugs or suggestions on the <bug-patch@gnu.org> mailing list, or
in the project's bug tracker on Savannah:

  http://savannah.gnu.org/projects/patch

Thanks,
Andreas
