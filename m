From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 03 Aug 2007 20:58:35 +0200
Message-ID: <46B37ADB.8020103@alum.mit.edu>
References: <46B2E8F3.30301@alum.mit.edu>	 <0BB549C6E74E24409FB20B3B1D1B6644029461C0@ATL1EX11.corp.etradegrp.com> <9e4733910708030841r31175efg4ea4ea41e852ab2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Patwardhan, Rajesh" <rajesh.patwardhan@etrade.com>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Guilhem Bonnefille <guilhem.bonnefille@gmail.com>, git@vger.kernel.org,
        users@cvs2svn.tigris.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: users-return-1615-gcvscu-users=m.gmane.org@cvs2svn.tigris.org Fri Aug 03 20:58:51 2007
Return-path: <users-return-1615-gcvscu-users=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscu-users@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IH2ML-0007iX-M6
	for gcvscu-users@gmane.org; Fri, 03 Aug 2007 20:58:50 +0200
Received: (qmail 30619 invoked by uid 5000); 3 Aug 2007 18:58:47 -0000
Mailing-List: contact users-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:users-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:users-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:users@cvs2svn.tigris.org>
Delivered-To: mailing list users@cvs2svn.tigris.org
Received: (qmail 30608 invoked from network); 3 Aug 2007 18:58:47 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAJYXs0bAbSoIemdsb2JhbACOEAIJCg
X-IronPort-AV: i="4.19,218,1183359600"; 
   d="scan'208"; a="63542424:sNHT19266128"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
Followup-To: users@cvs2svn.tigris.org
In-Reply-To: <9e4733910708030841r31175efg4ea4ea41e852ab2@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54743>

[I set followup-to users@cvs2svn.tigris.org, since this has nothing to
do with git.]

Jon Smirl wrote:
> On 8/3/07, Patwardhan, Rajesh <rajesh.patwardhan@etrade.com> wrote:
>> Hello Michael,
>> I will explain a scenario (we are passing thru this right now)
>> 1) you have 10 years worth of cvs data.
>> 2) We want to move to svn.
>> 3) The repository move should be in such a way that the development does
>> not get hampered for any 1 work day.
>> 4) We have atleast 4 major modules in cvs which takes about 30 - 40
>> hours each for conversion currently.
> 
> There are known ways (that haven't been implemented) to get the 40 hr
> number down to 1/2 hour. Would that be a better approach than doing
> incremental imports?

Jon, I would like very much to hear how you propose to get an 60-fold
speed increase in cvs2svn.  I've never heard of any plausible way to
accomplish anything even close to this.

Please note that the user wants to convert to Subversion, not git.  But
even converting to git, I don't think that such speeds are possible
without massive changes that would include processing everything in RAM
and switching large parts of cvs2svn from Python to a compiled language.

Michael
