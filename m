From: Marc Khouzam <marc.khouzam@ericsson.com>
Subject: RE: [PATCH v4] git-completion.bash: add support for path completion
Date: Mon, 7 Jan 2013 15:26:26 +0000
Message-ID: <E59706EF8DB1D147B15BECA3322E4BDC068EE8@eusaamb103.ericsson.se>
References: <1356108872-5881-1-git-send-email-manlio.perillo@gmail.com>
 <E59706EF8DB1D147B15BECA3322E4BDC0672D1@eusaamb103.ericsson.se>
 <7vobh4sffw.fsf@alter.siamese.dyndns.org>,<7vehi0qh4x.fsf@alter.siamese.dyndns.org>
 <E59706EF8DB1D147B15BECA3322E4BDC0681FA@eusaamb103.ericsson.se>
 <50EAD0FA.4050401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'git@vger.kernel.org'" <git@vger.kernel.org>,
	"'szeder@ira.uka.de'" <szeder@ira.uka.de>,
	"'felipe.contreras@gmail.com'" <felipe.contreras@gmail.com>
To: "'Manlio Perillo'" <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 16:27:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsEbT-0002HO-4g
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 16:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040Ab3AGP0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 10:26:45 -0500
Received: from imr4.ericy.com ([198.24.6.9]:57483 "EHLO imr4.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387Ab3AGP0o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jan 2013 10:26:44 -0500
Received: from EUSAAHC005.ericsson.se ([147.117.188.87])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id r07FeuxR004076;
	Mon, 7 Jan 2013 09:40:57 -0600
Received: from EUSAAMB103.ericsson.se ([147.117.188.120]) by
 EUSAAHC005.ericsson.se ([147.117.188.87]) with mapi id 14.02.0318.004; Mon, 7
 Jan 2013 10:26:26 -0500
Thread-Topic: [PATCH v4] git-completion.bash: add support for path completion
Thread-Index: AQHN35v9HSsVlTwzCk6LZCvwjOeDYpg5wPLQgAAkJX6AAHcaLIAA48SGgAMOjwD//8ifIA==
In-Reply-To: <50EAD0FA.4050401@gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.117.188.134]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212896>


> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Manlio Perillo
> Sent: Monday, January 07, 2013 8:43 AM
> To: Marc Khouzam
> Cc: Junio C Hamano; git@vger.kernel.org; szeder@ira.uka.de; 
> felipe.contreras@gmail.com
> Subject: Re: [PATCH v4] git-completion.bash: add support for 
> path completion
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Il 05/01/2013 21:23, Marc Khouzam ha scritto:
> > [...]
> > Below are two suggestions that are in line with this effort 
> but that are not regressions.
> > 
> > A) It would be nice if 
> > git commit -a <TAB>
> > also completed with untracked files
> > 
> 
> $ git commit -a foo
> fatal: Paths with -a does not make sense.
> 
> So
>   git commit -a <TAB>
> 
> should not suggest untracked files; instead it should suggest nothing.

You are right, I was confused.

git commit --all <TAB>

should also suggest nothing then.

Thanks

Marc