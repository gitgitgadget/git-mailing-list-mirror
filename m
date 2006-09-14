From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 00:34:52 -0400
Message-ID: <9e4733910609132134j63857912keed6a42682f69d66@mail.gmail.com>
References: <45084400.1090906@bluegap.ch>
	 <9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>
	 <46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>
	 <4508724D.2050701@bluegap.ch>
	 <46a038f90609131416s1a53b53xd12c3661140fec7a@mail.gmail.com>
	 <4508D7DA.8000302@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>, 
	"Markus Schiltknecht" <markus@bluegap.ch>, 
	"Git Mailing List" <git@vger.kernel.org>, monotone-devel@nongnu.org, 
	dev@cvs2svn.tigris.org
X-From: dev-return-1639-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Thu Sep 14 06:34:58 2006
Return-path: <dev-return-1639-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1GNiwA-0005wI-W4
	for gcvscd-dev@gmane.org; Thu, 14 Sep 2006 06:34:55 +0200
Received: (qmail 9179 invoked by uid 5000); 14 Sep 2006 04:34:53 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 9165 invoked from network); 14 Sep 2006 04:34:53 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAALJ4CEWLJkYCCQQRBh0
X-IronPort-AV: i="4.09,161,1157353200"; 
   d="scan'208"; a="26768784:sNHT19275361"
X-IRONPORT: SCANNED
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b+1G5k8MAw3m3zXrRfa6BkffWqGn6W+JvvH7qx95fLkZrXNy+EvRbQLo9Ejhm7l/lJTea7GQqV+drHhBbtA6JY8AL4Gx7+w2N0HcIpk/NXgcyXWt7MhfquqI0wkSyWqfwjLKmZKFSGSn4orLtG1UpD/jNY9MIvQodRZ5Yusosmk=
To: "Michael Haggerty" <mhagger@alum.mit.edu>
In-Reply-To: <4508D7DA.8000302@alum.mit.edu>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26980>

On 9/14/06, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> But aside from this point, I think an intrinsic part of implementing
> incremental conversion is "convert the subsequent changes to the CVS
> repository *subject to the constraints* imposed by decisions made in
> earlier conversion runs.  And the real trick is that things can be done
> in CVS (e.g., line-end changes, manual copying of files in the repo)
> that (a) are unversioned and (b) have retroactive effects that go
> arbitrarily far back in time.  This is the reason that I am pessimistic
> that incremental conversion will ever work robustly.

We don't need really robust incremental conversion. It just needs to
work most of the time. Incremental conversion is usually used to track
the main CVS repo with the new tool while people decide if they like
the new tool. Commits will still flow to the CVS repo and get
incrementally copied to the new tool so that it tracks CVS in close to
real time.

If the increment import messes up you can always redo a full import,
but a full Mozilla import takes about 2 hours with the git tools. I
would always do a full import on the day of the actual cut over.

-- 
Jon Smirl
jonsmirl@gmail.com
