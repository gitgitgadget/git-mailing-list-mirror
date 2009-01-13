From: Teemu Likonen <tlikonen@iki.fi>
Subject: Commit messages
Date: Tue, 13 Jan 2009 22:24:39 +0200
Message-ID: <8763kjt0mw.fsf_-_@iki.fi>
References: <496CBD17.3000207@tedpavlic.com>
	<20090113164518.GS10179@spearce.org>
	<200901131403.16012.bss@iguanasuicide.net>
	<20090113201024.GA20129@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ted Pavlic <ted@tedpavlic.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Adeodato =?iso-8859-1?Q?Sim=F3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Tue Jan 13 21:26:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMpqP-0008Eq-WD
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 21:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbZAMUZP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2009 15:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbZAMUZN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 15:25:13 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:43324 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbZAMUZM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 15:25:12 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48FC5B8903B08730; Tue, 13 Jan 2009 22:25:02 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LMpoV-000461-DS; Tue, 13 Jan 2009 22:24:39 +0200
In-Reply-To: <20090113201024.GA20129@chistera.yi.org> ("Adeodato
 =?iso-8859-1?Q?Sim=F3=22's?= message of "Tue\, 13 Jan 2009 21\:10\:24
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105530>

Adeodato Sim=F3 (2009-01-13 21:10 +0100) wrote:

> * Boyd Stephen Smith Jr. [Tue, 13 Jan 2009 14:03:11 -0600]:
>
>> My rule for this is absolutely no more than 80 characters.
>
> My rule for *all* of the commit message is "absolutely no more than 7=
6
> characters". With more than 76, `git log` wraps in a 80-column termin=
al.

Here's my rule:


(add-to-list 'auto-mode-alist
             '("/\\.git/\\(COMMIT\\|TAG\\)_EDITMSG\\'" .
               vcs-message-mode))

(define-derived-mode vcs-message-mode text-mode "VCS-message"
  "Major mode for editing commit and tag messages."=20
  (auto-fill-mode 1)
  (set (make-local-variable 'tab-stop-list)
       (number-sequence 4 100 4))
  (setq indent-tabs-mode nil
        fill-column 72
        truncate-lines t))
