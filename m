From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 17:11:26 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121125221126.GB6937@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
 <20121125173607.GB32394@thyrsus.com>
 <CAMP44s2fSpL13kDAm9W2ti-MERpKukNzNZ_Yt0oOOWMYOQPr2Q@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 23:12:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TckRG-0004qu-Pu
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 23:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab2KYWMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 17:12:20 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:44549
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab2KYWMT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 17:12:19 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id D0C004065F; Sun, 25 Nov 2012 17:11:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMP44s2fSpL13kDAm9W2ti-MERpKukNzNZ_Yt0oOOWMYOQPr2Q@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210387>

Felipe Contreras <felipe.contreras@gmail.com>:
> And are you going to be around to spot them? It seems my patches for
> git-remote-hg slipped by your watch, because it seems they use stuff
> specific to python 2.7.

The dev group hasn't decided (in whatever way it decides these
things) to require 2.6 yet.  When and if it does, I will volunteer my
services as a Python expert to audit the in-tree Python code for 2.6
conformance and assist the developers in backporting if required.
I will also make myself available to audit future submissions.  

I think you know who I am. Junio and the other senior devs certainly
know where to find me. I've been making promises like this, and
*keeping* them, for decades.  Please stop wasting our time with
petulant display.

> Exactly. Why would you reject something you can fix easily?

I wouldn't.  The point of a policy like this is not to kick incoming
submissions over the horizon as though that were some sort of
accomplishment, it's to let submitters know what is required of
them so they can code up to a standard that supports maintainability.
It would be no different than any of our other portability requirements.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
