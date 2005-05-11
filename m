From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH Cogito] match pathnames in exclude handling
Date: Wed, 11 May 2005 14:30:34 -0700
Message-ID: <4282797A.5020001@zytor.com>
References: <pan.2005.05.10.03.41.15.683163@smurf.noris.de> <428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de> <20050510080445.GB8176@lug-owl.de> <7vis1rpi8a.fsf@assigned-by-dhcp.cox.net> <20050510093212.GD8176@lug-owl.de> <20050510093924.GH11221@kiste.smurf.noris.de> <20050510094538.GE8176@lug-owl.de> <20050510095825.GI11221@kiste.smurf.noris.de> <4281281F.6000101@cobite.com> <20050511052546.GC11192@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Mansfield <david@cobite.com>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	Junio C Hamano <junkio@cox.net>,
	Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 23:25:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVygr-0007A5-QM
	for gcvg-git@gmane.org; Wed, 11 May 2005 23:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVEKVbx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 17:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVEKVbx
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 17:31:53 -0400
Received: from terminus.zytor.com ([209.128.68.124]:39605 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261222AbVEKVbr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 17:31:47 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4BLUiKb019793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 May 2005 14:30:44 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20050511052546.GC11192@kiste.smurf.noris.de>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.5 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias Urlichs wrote:
> 
> I already did, last week. (I do need to cleanup my changes...)
> 
> The idea is that "foo" matches anywhere, "foo/bar" the exact pathname.
> As a special case, "./foo" matches in the root directory only.
> 
> NB: "*" can cross subdirectory paths, so "*/foo/bar" does match
> "a/b/c/foo/bar".
> 

How does that mean foo*.c would match foo/bar/quux.c?  That's probably a 
bad thing.

I do like the (sadly, rarely used) convention that ** matches / whereas 
* doesn't.

	-hpa
