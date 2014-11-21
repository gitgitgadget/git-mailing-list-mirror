From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] copy.c: make copy_fd preserve meaningful errno
Date: Fri, 21 Nov 2014 10:17:51 +0100
Message-ID: <546F033F.7030201@alum.mit.edu>
References: <1416262453-30349-1-git-send-email-sbeller@google.com> <546F0284.7050904@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 10:18:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrkLp-0000XA-32
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 10:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758081AbaKUJR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 04:17:56 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:51466 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758016AbaKUJRy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 04:17:54 -0500
X-AuditID: 1207440c-f79376d00000680a-8e-546f03414dcc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 38.FB.26634.1430F645; Fri, 21 Nov 2014 04:17:53 -0500 (EST)
Received: from [192.168.69.130] (p5DDB272E.dip0.t-ipconnect.de [93.219.39.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAL9HpuB021923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 21 Nov 2014 04:17:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <546F0284.7050904@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqOvInB9icHebhUXXlW4mi4beK8wW
	b28uYbT4N6HGYvPmdhYHVo+ds+6yeyzYVOpx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGbt6
	L7IWbGGqmL+/iamB8RtjFyMnh4SAiUTTiWksELaYxIV769m6GLk4hAQuM0pcndDICuGcY5KY
	9OUzUIaDg1dAW2LJ1FIQk0VAVeLVshyQXjYBXYlFPc1MILaoQJDEyT3X2UFsXgFBiZMzn4DN
	FxHwk9h38QqYzSwQIfFx2UWwGmEBZ4kLr4+wgdhCAkkSf8+dYgaxOQV0JDY2f2SHqNeT2HH9
	FyuELS+x/e0c5gmMArOQrJiFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3QN9XIz
	S/RSU0o3MUJCmmcH47d1MocYBTgYlXh4VyzOCxFiTSwrrsw9xCjJwaQkyuvLmB8ixJeUn1KZ
	kVicEV9UmpNafIhRgoNZSYRX5DtQOW9KYmVValE+TEqag0VJnFd1ibqfkEB6YklqdmpqQWoR
	TFaGg0NJgleUCWioYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChO44uBkQqS4gHa
	GwfSzltckJgLFIVoPcWoy9HS9LaXSYglLz8vVUocokgApCijNA9uBSyBvWIUB/pYmPckyHs8
	wOQHN+kV0BImoCV/l+aCLClJREhJNTBWX5W6/9zlEDv/h60bmP6tuFBr5PZfStyswHV+8bv/
	u5XXMoarf9rAzFdfliZluVzurOqZPx9MxY4K3tae/j9zcpUcQ+/y09sDtdb8Wj7/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21/2014 10:14 AM, Michael Haggerty wrote:
> Couldn't we save ourselves a lot of this "save_errno" boilerplate by
> making error() and warning() preserve errno? [...]

Never mind; I see that Peff already submitted a patch to this effect.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
