From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Handling empty directories in Git
Date: Tue, 8 Apr 2014 13:20:02 -0400
Message-ID: <AE92C2A5-4EFE-454C-8D61-804AEE72D955@kellerfarm.com>
References: <1396968442.95061.YahooMailNeo@web120806.mail.ne1.yahoo.com> <3FBDE5D3-1DC6-420C-866B-036D0CB17BA2@kellerfarm.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Olivier LE ROY <olivier_le_roy@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 19:20:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXZhE-0003Bt-Px
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 19:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441AbaDHRUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 13:20:14 -0400
Received: from atl4mhob13.myregisteredsite.com ([209.17.115.51]:45299 "EHLO
	atl4mhob13.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757434AbaDHRUG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 8 Apr 2014 13:20:06 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.206])
	by atl4mhob13.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s38HK04T020071
	for <git@vger.kernel.org>; Tue, 8 Apr 2014 13:20:00 -0400
Received: (qmail 23198 invoked by uid 0); 8 Apr 2014 17:20:00 -0000
X-TCPREMOTEIP: 69.41.14.217
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO devnet.ces.cvnt.net) (andrew@kellerfarm.com@69.41.14.217)
  by 0 with ESMTPA; 8 Apr 2014 17:20:00 -0000
In-Reply-To: <3FBDE5D3-1DC6-420C-866B-036D0CB17BA2@kellerfarm.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245936>

On Apr 8, 2014, at 1:02 PM, Andrew Keller <andrew@kellerfarm.com> wrote:

> On Apr 8, 2014, at 10:47 AM, Olivier LE ROY <olivier_le_roy@yahoo.com> wrote:
> 
>> Hello, 
>> 
>> I have a project under SVN with contains empty directories.
>> 
>> I would like to move this project on a Git server, still handling empty directories.
>> 
>> The solution: put a .gitignore file in each empty directory to have them recognized by the Git database cannot work, because some scripts in my projects test the actual emptiness of the directories.
>> 
>> Is there any expert able to tell me: this cannot be done in Git, or this can be done by the following trick, or why there is no valuable reason to maintain empty directories under version control?
> 
> Git is designed to track files.  The existence of folders is secondary to the notion that files have a relative path inside the repository, which is perceived by the user as folders.

To clarify: That's Git's "personality" from the point of view of the front end, and is not the same as how data is actually stored.

Thanks,
Andrew Keller
