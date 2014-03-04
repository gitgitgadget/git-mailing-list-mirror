From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git compile with debug symbols
Date: Tue, 04 Mar 2014 17:03:59 +0100
Message-ID: <vpqtxbene6o.fsf@anie.imag.fr>
References: <1393947964.16150.YahooMailNeo@web162902.mail.bf1.yahoo.com>
	<87a9d6hsf3.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mahesh Pujari <pujarimahesh_kumar@yahoo.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:04:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKrpF-0003T6-V4
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 17:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbaCDQEJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2014 11:04:09 -0500
Received: from mx1.imag.fr ([129.88.30.5]:58712 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbaCDQEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 11:04:08 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s24G3wA3025507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Mar 2014 17:03:58 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s24G3xlL004011;
	Tue, 4 Mar 2014 17:03:59 +0100
In-Reply-To: <87a9d6hsf3.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Tue, 04 Mar 2014 16:53:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 04 Mar 2014 17:03:58 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s24G3wA3025507
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394553842.21319@WLa9AYHodWONwjZt32p4pw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243353>

David Kastrup <dak@gnu.org> writes:

> Mahesh Pujari <pujarimahesh_kumar@yahoo.com> writes:
>
>> Hello,
>> =A0I am trying to compile git with debug symbols and failed to do so
>> (basically I am a noob), can some one direct me to links or mailing
>> list (have searched but couldn't find) or doc's so that I can debug
>> git using gdb.
>
> git is compiled with debug symbols by default.

=2E.. but:

1) some Git commands are shell-scripts, on which you can't use gdb.

2) some Git commands fork other commands, and then you have to deal wit=
h
   multiple processes (i.e. putting a breakpoint in a piece of code
   executed by the subprocess won't work if gdb is running on the other
   one).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
