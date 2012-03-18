From: larsh-K3XMUd79hPisTnJN9+BGXg@public.gmane.org
Subject: [ANNOUNCE] CGIT 0.9.0.3
Date: Sun, 18 Mar 2012 10:27:13 +0000
Message-ID: <20120318102713.GA14884@hjemli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cgit-K3XMUd79hPisTnJN9+BGXg@public.gmane.org
X-From: cgit-bounces-K3XMUd79hPisTnJN9+BGXg@public.gmane.org Sun Mar 18 11:21:29 2012
Return-path: <cgit-bounces-K3XMUd79hPisTnJN9+BGXg@public.gmane.org>
Envelope-to: gcvc-cgit@m.gmane.org
Received: from li195-143.members.linode.com ([178.79.139.143] helo=hjemli.net)
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <cgit-bounces-K3XMUd79hPisTnJN9+BGXg@public.gmane.org>)
	id 1S9DEu-0004DI-OJ
	for gcvc-cgit@m.gmane.org; Sun, 18 Mar 2012 11:21:28 +0100
Received: from localhost ([127.0.0.1] helo=node.hjemli.net)
	by hjemli.net with esmtp (Exim 4.74)
	(envelope-from <cgit-bounces-K3XMUd79hPisTnJN9+BGXg@public.gmane.org>)
	id 1S9DKU-0003t0-Pk; Sun, 18 Mar 2012 10:27:14 +0000
Received: from larsh by hjemli.net with local (Exim 4.74)
 (envelope-from <larsh-K3XMUd79hPisTnJN9+BGXg@public.gmane.org>)
 id 1S9DKT-0003st-LU; Sun, 18 Mar 2012 10:27:13 +0000
Content-Disposition: inline
User-Agent: Mutt/1.4.2.3i
X-BeenThere: cgit-K3XMUd79hPisTnJN9+BGXg@public.gmane.org
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: list for cgit developers and users <cgit.hjemli.net>
List-Unsubscribe: <http://hjemli.net/mailman/options/cgit>,
 <mailto:cgit-request-K3XMUd79hPisTnJN9+BGXg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://hjemli.net/pipermail/cgit>
List-Post: <mailto:cgit-K3XMUd79hPisTnJN9+BGXg@public.gmane.org>
List-Help: <mailto:cgit-request-K3XMUd79hPisTnJN9+BGXg@public.gmane.org?subject=help>
List-Subscribe: <http://hjemli.net/mailman/listinfo/cgit>,
 <mailto:cgit-request-K3XMUd79hPisTnJN9+BGXg@public.gmane.org?subject=subscribe>
Errors-To: cgit-bounces-K3XMUd79hPisTnJN9+BGXg@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193376>

A bugfix release of cgit (a web interface to git repositories) is now
available from http://hjemli.net/git/cgit. Thanks to everyone who
contributed!

$ git shortlog v0.9.0.2..v0.9.0.3
Eric Wong (2):
      ui-ssdiff.c: correct length check for LCS table
      segfault fix on some bogus requests

Georg M=C3=BCller (1):
      ui-log.c: do not show remote heads if enable-remote-branches=3D0

Jamie Couture (2):
      ui-ssdiff: move LCS table away from the stack
      use correct type for sizeof

John Keeping (1):
      Fix segmentation fault in empty repository

Lars Hjemli (2):
      Makefile: fetch git tarballs from http://hjemli.net/git/git/
      CGIT-0.9.0.3

Lukas Fleischer (2):
      Remove dead initialization in cgit_parse_commit()
      Fix potential XSS vulnerability in rename hint

Norberto Lopes (1):
      fix css color value and vertical-align value

Tim Chen (1):
      Fix diff mode switching when side-by-side-diffs=3D1

Tobias Grimm (1):
      Add sort parameter to pager of repo list
