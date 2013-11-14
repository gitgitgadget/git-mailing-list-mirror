From: Jeff King <peff@peff.net>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Thu, 14 Nov 2013 03:07:35 -0500
Message-ID: <20131114080735.GB16327@sigill.intra.peff.net>
References: <CAMK1S_jY1tDCkyOamX8XNW9g8Dzf6yN9znwN6he-EVcOkBM1fQ@mail.gmail.com>
 <51A963B7.6060002@alum.mit.edu>
 <20130601050355.GA23408@sigill.intra.peff.net>
 <CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com>
 <20130601090934.GA13904@sigill.intra.peff.net>
 <CALkWK0mwAc0bFon7B7nw1Nbvcwdf8m2_531qtrN-r28r9F+70Q@mail.gmail.com>
 <CAMK1S_hPups3SCwxhHRYWBJzpPreNVUfNdx1+_Hjy2_d0MMpaA@mail.gmail.com>
 <CALkWK0=SqCh-82F4ud+AxuzzEezyMWqMvc6HAPoxOk32vUND7A@mail.gmail.com>
 <528416EA.1070307@gmail.com>
 <87bo1nmn6w.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Nov 14 09:07:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgrxl-0004QP-EF
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 09:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437Ab3KNIHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 03:07:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:38967 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751166Ab3KNIHh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 03:07:37 -0500
Received: (qmail 29115 invoked by uid 102); 14 Nov 2013 08:07:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 02:07:37 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 03:07:35 -0500
Content-Disposition: inline
In-Reply-To: <87bo1nmn6w.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237817>

On Thu, Nov 14, 2013 at 08:56:07AM +0100, Thomas Rast wrote:

> > Whatever it was that happened to a hundred or more repos on the Jenkins
> > project seems to be stirring up this debate in some circles.
> 
> Making us so curious ... and then you just leave us hanging there ;-)
> 
> Any pointers to this debate?

I do not know about any particular debate in git circles, but I assume
Sitaram is referring to this incident:

  https://groups.google.com/d/msg/jenkinsci-dev/-myjRIPcVwU/t4nkXONp8qgJ

in which a Jenkins dev force-pushed and rewound history on 150 different
repos. In this case the reflog made rollback easy, but if he had pushed
a deletion, it would be harder.

-Peff
