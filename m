From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Migrating away from SHA-1?
Date: Tue, 12 Apr 2016 18:58:10 -0700
Message-ID: <8722D9F3-8A42-4BF7-A945-305F483E8364@zytor.com>
References: <570D78CC.9030807@zytor.com> <CACsJy8DmPw+cbohp-X55bp9NJSbUVN=tsABXoF5Xh-6PgPTbiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 03:59:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqA5X-0007Og-5z
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 03:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbcDMB7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 21:59:23 -0400
Received: from terminus.zytor.com ([198.137.202.10]:46232 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964861AbcDMB7W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 21:59:22 -0400
Received: from [172.20.17.45] ([67.51.76.21])
	(authenticated bits=0)
	by mail.zytor.com (8.15.2/8.14.5) with ESMTPSA id u3D1wGwj015634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Apr 2016 18:58:17 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CACsJy8DmPw+cbohp-X55bp9NJSbUVN=tsABXoF5Xh-6PgPTbiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291365>

On April 12, 2016 6:51:12 PM PDT, Duy Nguyen <pclouds@gmail.com> wrote:
>On Wed, Apr 13, 2016 at 5:38 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>> OK, I'm going to open this can of worms...
>>
>> At what point do we migrate from SHA-1?
>
>Brian Carlson has been slowly refactoring git code base, abstracting
>SHA-1 away. Once that work is done, I think we can talk about moving
>away from SHA-1. The process is slow because it likely causes
>conflicts with in-flight topics. A quick grep shows we still have
>about 300 SHA-1 references, so it'll be quite some time.

Well, at least it sounds like work is underway.  That is a big deal.
-- 
Sent from my Android device with K-9 Mail. Please excuse brevity and formatting.
