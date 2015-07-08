From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 8/8] git-stash: use update-ref --create-reflog instead
 of creating files
Date: Wed, 08 Jul 2015 15:50:20 +0200
Message-ID: <559D2A9C.80401@alum.mit.edu>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com> <1436316963-25520-8-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 15:50:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCpkE-0001OS-Lh
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 15:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934106AbbGHNue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 09:50:34 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:54638 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932897AbbGHNud (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 09:50:33 -0400
X-AuditID: 1207440f-f79df6d000007c0f-62-559d2a9e01c8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.D5.31759.E9A2D955; Wed,  8 Jul 2015 09:50:22 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0310.dip0.t-ipconnect.de [93.219.3.16])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t68DoKRW010612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 8 Jul 2015 09:50:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1436316963-25520-8-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42IRYndR1J2nNTfUYNMjZYv5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3BmvO86yFbxjqTi05gZrA+NH5i5GTg4JAROJ
	rqZfjBC2mMSFe+vZuhi5OIQELjNK3Lq0jwnCOcMk8ebnayaQKl4BTYnWVZdYQGwWAVWJLdc3
	gtlsAroSi3qagWo4OEQFgiRev8yFKBeUODnzCViJiICDxOVdR8EWCwskSrxobYVa1soo8b3t
	IhtIglPAU+L1qSlgDcwCehI7rv9ihbDlJZq3zmaewMg/C8ncWUjKZiEpW8DIvIpRLjGnNFc3
	NzEzpzg1Wbc4OTEvL7VI10QvN7NELzWldBMjJCT5dzB2rZc5xCjAwajEw+sRMydUiDWxrLgy
	9xCjJAeTkihv3COgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeUMW5oUK8KYmVValF+TApaQ4W
	JXFe9SXqfkIC6YklqdmpqQWpRTBZGQ4OJQneS5pAjYJFqempFWmZOSUIaSYOTpDhXFIixal5
	KalFiaUlGfGgmIwvBkYlSIoHaO8hkHbe4oLEXKAoROspRl2OBT9ur2USYsnLz0uVEuc1AykS
	ACnKKM2DWwFLQK8YxYE+FuZtAqniASYvuEmvgJYwAS1ZrjsLZElJIkJKqoGR6eXUDwdWXzE/
	Gam5I5F/rdqxAJXti4VSH/B57v+jaMrz6aTfBjnR2cbuklsTOhqPJ9xfEDTHrS/xGsOuq07H
	xZ0uzrhb8uja1vsa95be/eRZGOEqc7byOcfSgH1nrLqF2QP+L763UeIy89KevR1H 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273685>

I apologize for getting involved so late in the evolution of this patch
series. Thanks for being so patient with the back-and-forth!

I'm really glad that you are working on this. It is important that this
area gets cleaned up if we are ever to support alternate reference
backends. And I'm happy that we will be getting new commands and command
options to deal with reflogs, because that was one case were users
previously had to muck about within the .git directory, which is a very
bad thing. We need to train users never to look behind the curtain!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
