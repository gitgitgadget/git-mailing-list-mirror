From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.5.1
Date: Sat, 17 Oct 2009 18:04:56 -0700
Message-ID: <7vws2t5x6v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 18 03:05:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzKDC-0004ys-0U
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 03:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118AbZJRBFI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2009 21:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753941AbZJRBFH
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 21:05:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921AbZJRBFG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Oct 2009 21:05:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B9CF17B8AC;
	Sat, 17 Oct 2009 21:05:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=DwJpfacBZXy7vtodWjxePDhpE
	I0=; b=Fe7+i6coJAPtP6eRMH+pl6LGp/UiIgTyy3AXBoAWyensDPmW3GF2uuM4w
	bhKBxt5lC2aU9BRrNJsPfJNsalI5AqnIiviIFoI0ZlLosCmYpdEo84wXYUJnhlFU
	W1hitcrHu0AF+618M+G8mX31g7ktyXW0X6BEWB/6Cr/c/FOflU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=NwXl9rbRV1JifMGiBHw
	BOhwWvf7UO/X4mkW/cxMNSvpw9dpaQ3mHfESVjqG9FBIghURuJOfxDeHeTblcAs9
	tls9j8c5fs69tlU/p0KXJzSx1WiNjXRtOngANzPm2RumkLB/BhlDq5m8BUizThwn
	IZAeCmV9SB1aswvEcIRKf/Wg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 847DB7B8AA;
	Sat, 17 Oct 2009 21:05:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 30FE07B8A9; Sat, 17 Oct 2009
 21:04:57 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 44F912BE-BB82-11DE-8202-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130582>

The latest maintenance release GIT 1.6.5.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.5.1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.5.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.5.1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.5.1-1.fc9.$arch.rpm	(RPM)

GIT v1.6.5.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.6.5
------------------

 * An corrupt pack could make codepath to read objects into an
   infinite loop.

 * Download throughput display was always shown in KiB/s but on fast li=
nks
   it is more appropriate to show it in MiB/s.

 * "git grep -f filename" used uninitialized variable and segfaulted.

 * "git clone -b branch" gave a wrong commit object name to post-checko=
ut
   hook.

 * "git pull" over http did not work on msys.

Other minor documentation updates are included.

----------------------------------------------------------------

Changes since v1.6.5 are as follows:

Bj=C3=B6rn Steinbrink (1):
      clone: Supply the right commit hash to post-checkout when -b is u=
sed

Johannes Sixt (1):
      remote-curl: add missing initialization of argv0_path

Junio C Hamano (1):
      GIT 1.6.5.1

Matt Kraai (1):
      grep: do not segfault when -f is used

Miklos Vajna (1):
      git-stash documentation: mention default options for 'list'

Nicolas Pitre (1):
      change throughput display units with fast links

Shawn O. Pearce (1):
      sha1_file: Fix infinite loop when pack is corrupted
