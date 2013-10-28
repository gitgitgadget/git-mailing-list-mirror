From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes:
 line
Date: Mon, 28 Oct 2013 09:27:02 +0100
Message-ID: <526E1FD6.7040404@alum.mit.edu>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda> <20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf> <xmqqa9hui2lp.fsf@gitster.dls.corp.google.com> <20131028071606.GA16878@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 28 09:34:20 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VaiHD-00005j-E6
	for glk-linux-kernel-3@plane.gmane.org; Mon, 28 Oct 2013 09:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab3J1IeL (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 28 Oct 2013 04:34:11 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49359 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751647Ab3J1IeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Oct 2013 04:34:09 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Oct 2013 04:34:09 EDT
X-AuditID: 12074413-b7fc76d000002aba-e1-526e1fd9856f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id ED.9E.10938.9DF1E625; Mon, 28 Oct 2013 04:27:05 -0400 (EDT)
Received: from [192.168.69.9] (p4FDD4EA3.dip0.t-ipconnect.de [79.221.78.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9S8R2VQ023291
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 28 Oct 2013 04:27:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <20131028071606.GA16878@leaf>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsUixO6iqHtTPi/IYEGrhcXrf9NZLLqudDNZ
	NPReYbY4t2AGo8X/BfkWt37MZbJ49egSk8XlXXPYHDg8br229Xj7MMDj94/JjB4fn95i8bh4
	Sdnj8ya5ALYobpukxJKy4Mz0PH27BO6MJ8ufshY0CVTMn/6NvYHxBk8XIyeHhICJxJXT59gg
	bDGJC/fWA9lcHEIClxklpj6dxQ6SEBI4yySx/31dFyMHB6+AtsT0ZQEgJouAqsSrt+EgFWwC
	uhKLepqZQGxRgRCJhauOg3XyCghKnJz5hAWkXETAV+JysyzIdGaBX4wS24/+AKsRFgiU6L0y
	jwVi7TVGidNHmxlBEpwCWhI9xx6xgNjMAjoS7/oeMEPY8hLb385hnsAoMAvJjllIymYhKVvA
	yLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdcLzezRC81pXQTIyQGhHcw7jopd4hRgINRiYc3
	YnVukBBrYllxZe4hRkkOJiVR3h65vCAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrx9t4DKeVMS
	K6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvAtAhgoWpaanVqRl5pQgpJk4
	OEGGc0mJFKfmpaQWJZaWZMSD4jS+GBipICkeoL15IO28xQWJuUBRiNZTjLoc8758+MYoxJKX
	n5cqJc47B6RIAKQoozQPbgUs4b1iFAf6WJh3O0gVDzBZwk16BbSECWjJHhawJSWJCCmpBkY5
	jkmeip6HxZxfHbXOqiqcfaZNRu8X46KOW9FqOmnbTjjo/JO7uXKKTIjK88Nfvi89 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236820>

On 10/28/2013 08:16 AM, Josh Triplett wrote:
> On Sun, Oct 27, 2013 at 06:52:18PM -0700, Junio C Hamano wrote:
>> There are unbound number of kinds of trailers people would want to
>> add, depending on their projects' needs.  We should not have to add
>> a specific support for a tailer like this one, before thinking
>> through to see if we can add generic support for adding arbitrary
>> trailers to avoid code and interface bloat.
>>
>> Think of the existing --signoff as a historical mistake.  Such a
>> generic "adding arbitrary trailers" support, when done properly,
>> should be able to express what "--signoff" does, and we should be
>> able to redo "--signoff" as a special case of that generic "adding
>> arbitrary trailers" support, and at that point, "Fixes:" trailer the
>> kernel project wants to use should fall out as a natural consequence.
> 
> Well, the add_signoff_extra function I added makes it easy to add any
> kind of trailing data you want to a commit; the question just becomes
> what the UI looks like to drive that.
> 
> Would you be OK with a solution that pushes the specific supported
> footer lines into git's configuration, and then supplies default
> configuration for common cases such as Fixes?  The option could become
> -f/--footer, and the configuration would specify how to parse various
> arguments of -f and turn them into something.  For example:
> 
> [footer "Fixes"]
>     abbrev = f
>     arg = commit
>     format = %h ('%s')

It could be even more decoupled, for example like this:

[footer "Fixes"]
    type = pipe
    cmd = awk '{ print $1 }' | git log --stdin --no-walk --abbrev=12
--pretty=format:\"Fixes: %h ('%s')\"

Note that the command is written to be idempotent; that way git could
re-pipe the old value(s) of the footer though the command if necessary.
 And it can handle multiple lines, since some callback scripts might
want to see all of them at once.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
