Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C3B20189
	for <e@80x24.org>; Wed, 22 Jun 2016 20:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbcFVUG2 (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:06:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:50485 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835AbcFVUG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:06:27 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MAkkB-1b4UXJ0qp1-00BtED; Wed, 22 Jun 2016 22:06:10
 +0200
Date:	Wed, 22 Jun 2016 22:06:08 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: work around t2300's assuming non-Windows
 paths
In-Reply-To: <xmqqa8idnpj9.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606222103410.10382@virtualbox>
References: <cover.1466246919.git.johannes.schindelin@gmx.de> <a8bebe126bcd047720a13e90b85b8dccb7231187.1466246919.git.johannes.schindelin@gmx.de> <xmqqmvmfu17f.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606211356170.22630@virtualbox>
 <xmqqr3bqqxhc.fsf@gitster.mtv.corp.google.com> <xmqqk2hiqwpb.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606220927350.10382@virtualbox> <xmqqa8idnpj9.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5KP/aWDiRqlszYBFnVvZUqOFmYZfFqcG1FJ79oiFMimAypdMrrZ
 FZEyrtDOsDQH1M8rMJ54mg732/37aZHQHMT1q2xue+rysQH18wNy1NW9Yseg5G7/yPRSoFQ
 w76rsvY6esWaKY8PhaMH2gcKqsuzu7qpj9pc05A4v+g7dmnbkgRx/8p1/UNymnjhA15WeS2
 SCahi9wzfdGcBN9cSWJBw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:TeHCB00dmIs=:8JaTPs9HvJ6XtcbxTgAelK
 4KzSKTF2X7/23ry3rVwPIo+7LYaqtlGbS4Cyyxwlbc97RwTk22uEOTg+4ANDI1qGT+5AyDlsw
 jVHQcsB6x8bV38CC03F+q4trbxpwePxHNk66JEmB1Gkwelh0bffLoch9L7SCOpGjJVza0WNiH
 3iT3BrXC7nU8Gdk/c3e6bNUvpZsOJ1WJXQOf+j9NedxbUVLvk38CkZLTiQRUDRJFRvBTcBcAT
 44bJq0PwmFF3naBPFTkY53E3FRyVDJttO0kLQaDZx8Qv5G4x70YBsXEYIt6JUuyE5OZelpL8A
 FQEN8dhsDldmL9xmZbTs9JhiNgnX1FrE7o6lv5MeL6qIe+LShT55Kfg8e9FOySbQbR6lZSyAn
 XRtrYtpN4FRYiT9EL5bWo058PQCb7IUf6eWzfiMMorrBDzYL6hQihjn2LQnRGmfuKtyM/CP6c
 ulzOQyBuGbqvxFKHAKCOIwzff0leEV62f1vuedaJ6F6O6eaxzNX+DMKVBAeptfTHjdHBOl2HB
 xJmfxaAaMbW3367bdI5CMKjh1fVL2+g/XT6ExIWsPZ7klepSN8s3+LNnIoTTZkH2hwJ6hm6so
 dJfANY4UgA6bmcYVyw9AndHT9wTv68807nBNJqb1RSfcXp4YhReLtlsXnnjAsyO/7yAwdd1FW
 JYTKQHCqPttS+slVNMs/5vTtGvYzt4c41FZVHzt1ppH8YGB/xEQxFawD7T+eHW8fMesY5nJAq
 /SzRjXmDiqqhlOHSkFZWiuufF+Y4W8hfDOVHtQ9eoAw+GxOe+J+OZDXbcgcLGC9csQQILPXrw
 CXdGBvQ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 22 Jun 2016, Junio C Hamano wrote:

> So let's take that "if Windows do this" change to t2300 as-is.

Thanks!
Dscho
