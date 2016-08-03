Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E6420229
	for <e@80x24.org>; Wed,  3 Aug 2016 14:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbcHCOWZ (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 10:22:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:50393 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932213AbcHCOWI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 10:22:08 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MRocn-1bfYw414gr-00Sy9O; Wed, 03 Aug 2016 16:21:29
 +0200
Date:	Wed, 3 Aug 2016 16:21:28 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	"jonsmirl@gmail.com" <jonsmirl@gmail.com>
cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: Making file permissions match
In-Reply-To: <CAKON4OyiG=ddx77Bn3h-YAh-3BYGd2rXPb9smwaooWxfBmtDKw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608031620490.107993@virtualbox>
References: <CAKON4OyiG=ddx77Bn3h-YAh-3BYGd2rXPb9smwaooWxfBmtDKw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:q/KllcXFR8QfoNZ4GSkyHv0ZqHXJFXJrSXidGhMr45ur5Y5o+KQ
 RhGTGiaS7N7gUmRDWOBm2k2sxbN6Q2JEaJhOpSEKvvduQeGi5hyYVI38me4f8eogvK3WvnU
 j1GM2gY+8CxzYMeaYb+4GEWPZ7Aruc7C9MTfJTJCSeDwIVLElrzAhdUQPbxcuxKbYj6OnCr
 oSpnhBMjCzFXebP+4hJHQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:7CfQFYkhD1U=:hWDY4WQRk/GRupLPwnxCvY
 blTvnYDYvI+tutxTQ3aYAgmxu47sNE5B1SHEku1hJhG6Ua5qgXF9V4KDGgK79KIhgy/v8Z2Us
 F8zFNmOL7mc/KWonPzJY38kTke1FPXHzEbsjvCAaozL8cp0Gc4O7canVU5PbjV+R/a8eAQO1n
 HCfomRR7JI6VI84FbzMF1dpe+TbVeSqzS0e+u9f27zZESFnv0fWs2s4QSmmd+Ev6/oNw2yOBd
 1kkSU8s0MotviRrJNwKXCdwS6Q4PVaXqlhoEkXS3Y5CsINi5CaglSXzCLzmbdRLwbAlZtpwPM
 YJOg3gO7DekH93anQZen7QzTbGc3yZS63amR7fopebNSFeFu7X/9gtHoBuOyxXECj5TsMbTwX
 OF3oWK762Lt5MYKXToUmGd0aho1P2m0mp5Kv/qABtLhURTMWfNlzoKeWaSwOdTCYepxiI5Q52
 xWO9r4RCU3R3ANI/UwP7VTLlphvyO3WgySFWXIqawmpXGITNt3UJIw8eKl3X3ODaPMg1oTDge
 jF6STBX7JWOGKeHuLwlFMKPqqWEnhfxATAOybq9oYJ/Nfh1WJVoC6xb5rO8owflwTwNxK/Wf4
 tE7K+T//yzde1/xBh0qpVEHABLPTNyfDboFbznmBkwzDoy7ROEZuXVl1vIqreVF02SQqygZAF
 nhTHE9FX2IA6WlJ9nZz0PLbAfZQAlLkpjOKGFtI/GjSFZbsXKfxf0lgzNuAJCksAJ00+YPb+E
 rQcT84LelESfEmn+L7u+boN6I5XnGkKPMQkS/aVqKpK3RWG8plOQa0dFUyRUN6ALSDwW6B7K8
 R9TN1tp
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Jon,

On Wed, 3 Aug 2016, jonsmirl@gmail.com wrote:

> I'm working with some Windows programmers that don't believe in file
> permissions They keep sending me zip files of their source tree.  I
> have my copy of the tree in git on Linux with all of the correct file
> permissions.
> 
> So I unzip the archive they send me and to see what they changed. I
> unzip it on top of my git tree. But now all of the file permissions
> don't match. The code deltas are there but there is also all of this
> noise from the file permissions.
> 
> Is there an easy way to deal with this? I want to keep the code deltas
> and ignore the permission changes. Since there are about 100K files
> this is too much to do manually.

Maybe setting core.filemode=false before committing?

Ciao,
Johannes
