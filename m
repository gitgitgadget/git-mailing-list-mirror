From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/3] git-multimail: Add an option to filter on branches
Date: Wed, 22 Apr 2015 12:39:28 +0200
Message-ID: <55377A60.707@alum.mit.edu>
References: <1429657487-10809-1-git-send-email-daveboutcher@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Dave Boutcher <daveboutcher@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 12:47:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YksBJ-0002Wp-O1
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 12:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540AbbDVKqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 06:46:55 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:61650 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756468AbbDVKql (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 06:46:41 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Apr 2015 06:46:41 EDT
X-AuditID: 12074411-f79fa6d000006b8a-d7-55377a611023
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id C6.CB.27530.16A77355; Wed, 22 Apr 2015 06:39:29 -0400 (EDT)
Received: from [192.168.69.130] (p4FC971D5.dip0.t-ipconnect.de [79.201.113.213])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3MAdSLs007399
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 22 Apr 2015 06:39:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1429657487-10809-1-git-send-email-daveboutcher@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42IRYndR1E2sMg812NhuZbFlx09mi64r3UwO
	TB47Z91l9/i8SS6AKYrbJimxpCw4Mz1P3y6BO+PNhGeMBTtZK1q/v2VvYNzM0sXIySEhYCLx
	7cQ8ZghbTOLCvfVsXYxcHEIClxklju7czwjhXGCS2PH7MjtIFa+AusS0f7/ZQGwWAVWJT3vv
	gXWzCehKLOppZgKxRQWCJFqvTWWEqBeUODnzCdg2EQF7iW37jrB2MXJwCAt4S6yfwwcSFhJw
	k/j44xpYCaeAu0TzvrdgrcwCehI7rv9ihbDlJba/ncM8gZF/FpKps5CUzUJStoCReRWjXGJO
	aa5ubmJmTnFqsm5xcmJeXmqRrqlebmaJXmpK6SZGSEAK7mCccVLuEKMAB6MSD+8KdvNQIdbE
	suLK3EOMkhxMSqK8z8qBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4i1OAcrwpiZVVqUX5MClp
	DhYlcV6+Jep+QgLpiSWp2ampBalFMFkZDg4lCd7LFUCNgkWp6akVaZk5JQhpJg5OkOFcUiLF
	qXkpqUWJpSUZ8aCIjC8GxiRIigdor1YlyN7igsRcoChE6ylGXY47U/4vYhJiycvPS5US5zUB
	KRIAKcoozYNbAUs/rxjFgT4W5u0FqeIBpi64Sa+AljABLYnbZgKypCQRISXVwMjeosbpfbxq
	Y+HRHcu61uxNnj756P7d9WWHjjT+YjVKE3/UW7GP2e9R99tgmxcTd1flaZh78NgKHXGTfeBz
	JWB6uuvT01erM8+KTX5cNjfh+k+h0ylWMldutJ4t3cEjIqEf7Wz+K6Rv8y/GKdUO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267586>

On 04/22/2015 01:04 AM, Dave Boutcher wrote:
> Add a branches option to the config.  Only changes
> pushed to specified branches will generate emails. Changes to tags
> will continue to generate emails.

Thanks for the patches. Patches 2 and 3 seem uncontroversial, so I
already merged them. Patch 1 is more interesting, and there have been
other proposals for similar features, so I created a pull request for it:

    https://github.com/git-multimail/git-multimail/pull/75

(Note the new URL--I just created a GitHub "organization" for
git-multimail to make it easier for other people to get involved. More
info soon...)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
