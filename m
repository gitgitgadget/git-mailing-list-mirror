From: "Pedroso, Osiris" <osiris.pedroso@intergraph.com>
Subject: Ability to remember last known good build
Date: Fri, 11 Mar 2016 17:51:33 +0000
Message-ID: <CEDF59214E9E6A4CB418120F4FD7A0056E86A214@US-MBX2.ingrnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 11 18:58:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeRKA-0003VF-8U
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 18:58:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbcCKR6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 12:58:01 -0500
Received: from us-smtp-delivery-121.mimecast.com ([216.205.24.121]:59977 "EHLO
	us-smtp-delivery-121.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750705AbcCKR6A convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 12:58:00 -0500
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Mar 2016 12:57:59 EST
Received: from US-CASHT3.ingrnet.com (us-casht3.ingrnet.com
 [129.135.112.43]) (Using TLS) by us-smtp-1.mimecast.com with ESMTP id
 us-mta-21-Zp5kq8CbS3ijl0lN3JYqpw-1; Fri, 11 Mar 2016 12:51:35 -0500
Received: from US-MBX2.ingrnet.com ([169.254.2.26]) by US-CASHT3.ingrnet.com
 ([129.135.112.43]) with mapi id 14.03.0248.002; Fri, 11 Mar 2016 11:51:33
 -0600
Thread-Topic: Ability to remember last known good build
Thread-Index: AdF7vloP4/VPviANTSGOInvV97MWlw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [129.135.112.82]
X-MC-Unique: Zp5kq8CbS3ijl0lN3JYqpw-1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288692>

I participate in an open source project that any pull merge is accepted, no matter what.

This makes for lots of broken builds, even though we do have Travis-CI enabled on the project, because people will merge a request before even the build is complete.

Therefore, I would like to remember the id of the commit of the last successful build. This would be updated by the Travis-CI script itself upon a successful build.

I imagine best option would be to merge master to a certain branch named "Last_known_Linux_build" or "Last_known_Windows_build" or even "Last_known_build_all_tests_passing".

I am new to git, but some other experienced co-volunteers tell me that it may not be possible due to authentication issues.

Any better way of accomplishing this?

Appreciate any comments,
Osiris Pedroso
