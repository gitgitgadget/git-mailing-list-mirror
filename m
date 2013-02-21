From: "Kraai, Matt" <Matt.Kraai@amo.abbott.com>
Subject: RE: QNX support
Date: Thu, 21 Feb 2013 10:04:41 -0800
Message-ID: <1B04D3EE58602B43B7D34ECC7F9E321E060FA821@SANMAIL04.corp.amo-inc.com>
References: <430B4DD0-B796-4DB2-861D-C1F81302A4D1@aveco.com> <7vmwuxv9ou.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	=?iso-8859-2?Q?David_Ond=F8ich?= <david.ondrich@aveco.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 19:25:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8apP-0001RJ-79
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 19:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464Ab3BUSYm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2013 13:24:42 -0500
Received: from cuda2.amo-inc.com ([129.33.114.232]:56145 "EHLO
	cuda2.amo-inc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598Ab3BUSYl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2013 13:24:41 -0500
X-Greylist: delayed 1170 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Feb 2013 13:24:41 EST
X-ASG-Debug-ID: 1361469905-0482093e8f6e9fce0001-QuoKaX
Received: from AMOMAIL12.corp.amo-inc.com ([172.17.223.23]) by cuda2.amo-inc.com with ESMTP id UUZsZH30YYIVNbFV; Thu, 21 Feb 2013 10:05:05 -0800 (PST)
X-Barracuda-Envelope-From: Matt.Kraai@amo.abbott.com
Received: from SANMAIL04.corp.amo-inc.com ([172.17.10.200]) by AMOMAIL12.corp.amo-inc.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 21 Feb 2013 12:03:39 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: QNX support
In-Reply-To: <7vmwuxv9ou.fsf@alter.siamese.dyndns.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: QNX support
Thread-Index: Ac4QW6F8F3joD/YDR4uKPY46K3ZobQAAWTGA
X-OriginalArrivalTime: 21 Feb 2013 18:03:39.0880 (UTC) FILETIME=[C71B9680:01CE105D]
X-Barracuda-Connect: UNKNOWN[172.17.223.23]
X-Barracuda-Start-Time: 1361469905
X-Barracuda-URL: http://cuda2.amo-inc.com:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at amo-inc.com
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5035 1.0000 0.7500
X-Barracuda-Spam-Score: 0.77
X-Barracuda-Spam-Status: No, SCORE=0.77 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=BSF_SC0_MISMATCH_TO, THREAD_INDEX, THREAD_TOPIC
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.123215
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 THREAD_INDEX           thread-index: AcO7Y8iR61tzADqsRmmc5wNiFHEOig==
	0.01 THREAD_TOPIC           Thread-Topic: ...(Japanese Subject)...
	0.00 BSF_SC0_MISMATCH_TO    Envelope rcpt doesn't match header
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216786>

Junio C Hamano writes:
> "David Ond=F8ich" <david.ondrich@aveco.com> writes:
> > I've read [1] recently, there's been some QNX port being
> > initiated. Does that involve also old versions of QNX 4?

No, I haven't been working on QNX 4 support.  I've been targeting QNX 6=
=2E3.2, with a little testing on QNX 6.5.0.  I doubt what I've done wou=
ld work on QNX 4 since it's so different from QNX 6.
=20
> > Since we are using QNX both internally and for our customers we
> > started porting Git on QNX ourselves some time ago and we do have
> > some experiences. Basically, it's possible to get Git up and
> > running but there are some limitations, and some hacks have to be
> > applied.
> >
> > If some additional info wanted, please contact me.

Now that Git is building and usable, the next logical step is to invest=
igate and fix the test suite failures.  If you have any information abo=
ut these, that could be helpful.

--=20
Matt
