From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 03:28:30 +0200
Message-ID: <200610180328.31234.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<20061018000026.GH20017@pasky.or.cz> <45357596.8050702@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, bazaar-ng@lists.canonical.com,
	Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Wed Oct 18 03:28:01 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga0Dx-0007Km-D0
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 18 Oct 2006 03:28:01 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Ga0Dw-0003py-PH; Wed, 18 Oct 2006 02:28:00 +0100
Received: from ug-out-1314.google.com ([66.249.92.175])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <jnareb@gmail.com>) id 1Ga0Du-0003ps-Ue
	for bazaar-ng@lists.canonical.com; Wed, 18 Oct 2006 02:27:59 +0100
Received: by ug-out-1314.google.com with SMTP id 36so75926ugg
	for <bazaar-ng@lists.canonical.com>;
	Tue, 17 Oct 2006 18:27:58 -0700 (PDT)
Received: by 10.67.105.19 with SMTP id h19mr2548928ugm;
	Tue, 17 Oct 2006 18:27:58 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
	by mx.google.com with ESMTP id x26sm309175ugc.2006.10.17.18.27.57;
	Tue, 17 Oct 2006 18:27:57 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <45357596.8050702@utoronto.ca>
Content-Disposition: inline
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29159>

Aaron Bentley wrote:
> Petr Baudis wrote:
>>
>> Another aspect of this is that Git (Linus ;) is very focused on getting
>> the history right, nice and clean (though it does not _mandate_ it and
>> you can just wildly do one commit after another; it just provides tools
>> to easily do it).
> 
> Yes, rebasing is very uncommon in the bzr community.  We would rather
> evaluate the complete change than walk through its history.  (Bundles
> only show the changes you made, not the changes you merged from the
> mainline.)
> 
> In an earlier form, bundles contained a patch for every revision, and
> people *hated* reading them.  So there's definitely a cultural
> difference there.

Take for example 
 "[PATCH 0/6] ref deletion and D/F conflict avoidance with packed-refs."
 http://thread.gmane.org/gmane.comp.version-control.git/28150/focus=28154

> This series cleans up the area that was affected by the recent
> addition of "packed-refs".  Christian Couder and Jeff King CC'ed
> since they seem to be touching in the general vicinity of the
> code these patches touch.
> 
> [1/6] ref locking: allow 'foo' when 'foo/bar' used to exist but not anymore.
> [2/6] refs: minor restructuring of cached refs data.
> [3/6] lock_ref_sha1(): do not sometimes error() and sometimes die().
> [4/6] lock_ref_sha1(): check D/F conflict with packed ref when creating.
> [5/6] delete_ref(): delete packed ref
> [6/6] git-branch: remove D/F check done by hand.
> 
> I opted for removing from the packed-ref file when a ref that is
> packed is deleted.

Isn't it easier to review than "bundle", aka. mega-patch?
