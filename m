From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 17:21:16 +1200
Message-ID: <46a038f90609132221o125c4694r75dbc8f728104832@mail.gmail.com>
References: <45084400.1090906@bluegap.ch>
	 <9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>
	 <46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>
	 <4508724D.2050701@bluegap.ch>
	 <46a038f90609131416s1a53b53xd12c3661140fec7a@mail.gmail.com>
	 <4508D7DA.8000302@alum.mit.edu>
	 <9e4733910609132134j63857912keed6a42682f69d66@mail.gmail.com>
	 <4508E26B.5000106@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>, "Markus Schiltknecht" <markus@bluegap.ch>, 
	"Git Mailing List" <git@vger.kernel.org>, monotone-devel@nongnu.org, 
	dev@cvs2svn.tigris.org
X-From: dev-return-1644-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Thu Sep 14 07:21:28 2006
Return-path: <dev-return-1644-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1GNjf5-0004eN-V0
	for gcvscd-dev@gmane.org; Thu, 14 Sep 2006 07:21:20 +0200
Received: (qmail 1006 invoked by uid 5000); 14 Sep 2006 05:21:18 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 996 invoked from network); 14 Sep 2006 05:21:18 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAACKDCEWLJkYCAgcECAkGHQ
X-IronPort-AV: i="4.09,161,1157353200"; 
   d="scan'208"; a="33910614:sNHT17504522"
X-IRONPORT: SCANNED
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DggVLC0lyeTHUhGlTzu4wlCevYoD9dx/v9UhOJDQ/il4FDPqEXWRvh3fRGa7+qUvh4cySsFxJHtlDogjkb02a2VytWvHAdy9wKfpUs+sz9R4LZ1CouajziiMctWeSND60yUD3q8mfNc5onuSn9j6opMo71fjravfzAwiYjrwJAI=
To: "Michael Haggerty" <mhagger@alum.mit.edu>
In-Reply-To: <4508E26B.5000106@alum.mit.edu>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26983>

On 9/14/06, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> 2. Long-term continuous mirroring (backwards and forwards) between CVS
> and another SCM, to allow people to use their preferred tool.  (I
> actually think that this is a silly idea, but some people seem to like it.)

Call me silly ;-) I use this all the time to track projects that use
CVS or SVN, where I either

 - Do have write access, but often develop offline (and I have a bunch
of perl/shell scripts to extract the patches and auto-commit them into
CVS/SVN).

 - Do have write access, but want to experimental work branches
without making much noise in the cvs repo -- and being able to merge
CVS's HEAD in repeatedly as you'd want.

 - Run "vendor-branch-tracking" setups for projects where I have a
custom branch of a FOSS sofware project, and repeatedly import updates
from upstream. this is the 'killer-app' of DSCMs IMHO.

It is not as robust as I'd like; with CVS, the git imports eventually
stray a bit from upstream, and requires manual fixing. But it is
_good_.

cheers,


martin
