From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Tue, 12 Jan 2016 09:39:53 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601120939270.2964@virtualbox>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 09:40:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIuV7-0007T8-3g
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 09:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761879AbcALIkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 03:40:19 -0500
Received: from mout.gmx.net ([212.227.15.15]:52322 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934142AbcALIj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 03:39:59 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0McmS9-1aaqqp0wDp-00HxtP; Tue, 12 Jan 2016 09:39:54
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:FgAZFUMjeY61aPmyWwGka8b6kfLJ/Fp/hZ2Hk+EopFNdd8AcaxY
 C3IlQvWRqvH8mVEQapmmT2EvaeLlCb96ROwpC8GzkUEmGE/rTtZPgd+ClIsYL4GpeRx4AP6
 ThUYKjgGeX4upB3F6FdPIwp6WRjxdOoLJsPboBjxZZk8SGkxZf+i3aJqYTlj39uviNVn/iE
 3WsVi6G8wP2eW159dMeMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L2rLPGWkvlE=:idOKAzVGiN5dVLMDDa8p9V
 Fqgli0xf+6Kx1SEbr3IH9citWfME7GMxcN95b4q+aHoXKiHiDLeYu4UTYK6EOJ8nFjgx7QIZx
 /2wbl1FPp6g9I7PmS0o2VrJPPnKNwUJKByAhhsOVNK8SLvjwAXNsjPXtZfVCq0vNjAtWAMsa8
 mpDor2q/bdfiDL0ClRWCaGieItq/byV5L696n2Z9KzId9e6QV4ZUlaVfK6xOa4AcJQrwsUGjw
 5Goa2IX9MV536eiIJJMpvpKo/SrBHYd9VQQLbqXevhef+3SMQu/dIa1s5SSNXAVnqiZvKc+VM
 lXMS2DVKyuRif9ul4nuoWeCN76MvRAGYbLVJJ3Y11S6JnWBH/D4O1FdHeTF4N8oE63ctBUTlC
 1gqKynAjvoA/sRCajnryR4d9OQLkLfMntmVeUHCkJ7XkwQA2bOCZ0RVfQR8nC5+d4+xFQ0QVY
 ZNl1/fM8Y+IMiUIPuMXRdunAEQ6kSCFd4Diy5iy3HQD0nfYYHGU4nvH+s4Jss6DphOFrnmWQg
 g+Ql0Fg8qZ/GwB9215pVYeyW5EpcLwZuEowPXx3sKIgIYc1ij7tuQU/SMHdfjMHAMSwh+i0jE
 p2daGaHhojfz7deVHKpXQNT1D3VY3leZdRADl3svOQXhERJ6rEej8tAUSi3NVTuoUpTlj5XEK
 /Ep1H9+blNqT65bRbrka/vnIDaVGv55mZs8IxUEvqXHT8wNhNs1Hw+RYcpGrGR7NfShjumja/
 0cSL+YZxxiM2j6v4YH6o7hYft7siHINaqx2AEjDOhM36wUHRcUFr/VJ+yPp6uuUhSEdhCMl6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283778>

Hi Junio,

On Mon, 11 Jan 2016, Junio C Hamano wrote:

> * jc/strbuf-gets (2015-12-16) 17 commits
>  - test-sha1-array: read command stream with strbuf_getline_crlf()
>  - grep: read -f file with strbuf_getline_crlf()
>  - send-pack: read list of refs with strbuf_getline_crlf()
>  - column: read lines with strbuf_getline_crlf()
>  - cat-file: read batch stream with strbuf_getline_crlf()
>  - transport-helper: read helper response with strbuf_getline_crlf()
>  - clone/sha1_file: read info/alternates with strbuf_getline_crlf()
>  - remote.c: read $GIT_DIR/remotes/* with strbuf_getline_crlf()
>  - ident.c: read /etc/mailname with strbuf_getline_crlf()
>  - rev-parse: read parseopt spec with strbuf_getline_crlf()
>  - revision: read --stdin with strbuf_getline_crlf()
>  - hash-object: read --stdin-paths with strbuf_getline_crlf()
>  - mktree: read textual tree representation with strbuf_getline_crlf()
>  - update-index: read list of paths with strbuf_getline_crlf() under --stdin
>  - update-index: read --index-info with strbuf_getline_crlf()
>  - check-attr, check-ignore, checkout-index: read paths with strbuf_getline_crlf()
>  - strbuf: make strbuf_getline_crlf() global
> 
>  Teach codepaths that communicate with users by reading text files
>  to be more lenient to editors that write CRLF-terminated lines.
>  Note that this is only about communication with Git, like feeding
>  list of object names from the standard input instead of from the
>  command line, and does not involve files in the working tree.
> 
>  Rerolled.
>  Needs review.

Actually, it waits for a re-roll ;-)

Ciao,
Dscho
