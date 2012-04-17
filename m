From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from
 remote remote"
Date: Mon, 16 Apr 2012 20:46:07 -0500
Message-ID: <CAGdFq_ga1+aPi6buBtRgm3pt+_nic9xn0arBPQbmDn8=Q=S5KA@mail.gmail.com>
References: <4F893CD8.5020700@gmail.com> <20120414201446.GB29999@ecki>
 <4F8A0F96.5060408@gmail.com> <20120415011118.GA4123@ecki> <4F8A8211.2010908@gmail.com>
 <20120415105943.GD6263@ecki> <4F8AAE7C.1020507@gmail.com> <20120415114518.GB9338@ecki>
 <4F8AB7F1.1020705@gmail.com> <20120415125140.GA15933@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Apr 17 03:46:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJxVP-0006gL-HN
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 03:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab2DQBqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 21:46:50 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49918 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab2DQBqt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 21:46:49 -0400
Received: by vcqp1 with SMTP id p1so3752219vcq.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 18:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qL4r/EGIPDL0u4ocfjvvcLkwK3uz65HcAXitBzjC4gQ=;
        b=IzHJkhAw85J+2th6vj0kA2jdspRYphHiGHuBz9xZ1s7uhc9V9kxoxVbJmdSpkkgC+/
         sJSnuBcuUVMqsySGBxqRqlQ0Mcy45tj+x8tvQs8OHGzK9abi6H5UO+CVPb88kbb+WSto
         0yhsKRI4HsykKZyAVJ4I3FXRXcr4dFZO9E61RIF7/GXGP0VLzwltJbQ8k2glr0QiGXGD
         NYezzyWFatd2kE45tEQNk7xuS/qMIPinsN/JFc7h2k9WBis1gz4hZdAzNdO7Aj9VnIVr
         MZxf4DQqUsRZACGiGhAzGXHTVCZZ70U+kR7QIeMq5o1lyPIM9WPSdopttV1jwFRyGKDa
         YgpA==
Received: by 10.52.29.99 with SMTP id j3mr3329581vdh.67.1334627208562; Mon, 16
 Apr 2012 18:46:48 -0700 (PDT)
Received: by 10.220.118.206 with HTTP; Mon, 16 Apr 2012 18:46:07 -0700 (PDT)
In-Reply-To: <20120415125140.GA15933@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195731>

On Sun, Apr 15, 2012 at 07:51, Clemens Buchacher <drizzd@aon.at> wrote:
> The 'pushing to local repo' test of t5800 which pushes using
> git-remote-testgit.py results in a deadlock for Stefano. Invoking
> fast-export/fast-import manually seems to work, however. I don't know
> what else to try at this point.
>
> I am pasting some relevant results below.

Junio ran into the same problem before, so far no-one has been able to
figure out why this is happening and/or under what circumstances.

-- 
Cheers,

Sverre Rabbelier
