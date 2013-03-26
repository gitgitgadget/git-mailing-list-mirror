From: Jeff King <peff@peff.net>
Subject: Re: git ate my home directory :-(
Date: Tue, 26 Mar 2013 13:48:04 -0400
Message-ID: <20130326174804.GB10383@sigill.intra.peff.net>
References: <5150C3EC.6010608@nod.at>
 <20130325214343.GF1414@google.com>
 <7vboa7w2vm.fsf@alter.siamese.dyndns.org>
 <384BCFE976364F1EA6E56306566D003A@PhilipOakley>
 <51519DA0.4090201@nod.at>
 <20130326145637.GA3822@sigill.intra.peff.net>
 <5151D589.2000002@nod.at>
 <CANgJU+Wihp=rSQevij6R7SnZtW8UpDtRpFYE00aKKAwiYi9Q_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Richard Weinberger <richard@nod.at>,
	Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 18:48:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKXzF-0000ww-Qz
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 18:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362Ab3CZRsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 13:48:10 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40445 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693Ab3CZRsI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 13:48:08 -0400
Received: (qmail 5374 invoked by uid 107); 26 Mar 2013 17:49:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 13:49:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 13:48:04 -0400
Content-Disposition: inline
In-Reply-To: <CANgJU+Wihp=rSQevij6R7SnZtW8UpDtRpFYE00aKKAwiYi9Q_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219174>

On Tue, Mar 26, 2013 at 06:20:09PM +0100, demerphq wrote:

> Seconded. At $work lots of people started asking anxious questions
> about this. It was suggested it is a potential security hole, although
> I am not sure I agree, but the general idea being that if you could
> manage to set this var in someones environment then they might use git
> to do real damage to a system. (The counterargument being that if you
> can set that in someones environment you can do worse already... But
> im a not a security type so I cant say)

IMHO, that is just silly. Setting GIT_WORK_TREE=/ would be just as
destructive. Or GIT_EXTERNAL_DIFF="rm -rf /" (or GIT_PAGER, etc).
If there is a danger to the implicit-workdir behavior, it is due to
accidental usage, not from a malicious attack.

-Peff
