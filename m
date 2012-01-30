From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: commit/from command in git-fast-import
Date: Mon, 30 Jan 2012 09:35:54 -0600
Message-ID: <CAGdFq_jG6=mQvQ9c3gxRy1p0Cvy-eJ7k37SNoZqT5-Dx5HW0Ew@mail.gmail.com>
References: <20120127124837.GA24084@glandium.org> <CAFfmPPPYc=9BdwuE+ANiHKrFk+_7aXDgnMv3fHxVmF0ttZu8bA@mail.gmail.com>
 <20120127140808.GA31535@glandium.org> <CAFfmPPN9BOp3tDetEeMjVmfFam3bgHzf=q5Am4OkTz0TqLWfbQ@mail.gmail.com>
 <20120127144702.GA6693@glandium.org> <CAFfmPPM_xqZoMd391UdqRtK5bgW5V2z9Mg=8LYLA7ZVZQGR3Mg@mail.gmail.com>
 <20120127210936.GC3124@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Barr <davidbarr@google.com>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 16:36:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrtHe-0004T4-3U
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 16:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab2A3Pgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 10:36:37 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54144 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752916Ab2A3Pgf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 10:36:35 -0500
Received: by lagu2 with SMTP id u2so2265244lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 07:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r8uDyjBgOxQdmKmboQXnOlvWqq8VlbaB/ime35elYig=;
        b=xCP5TuWKthSf5Sa5D8AzBlJaknz74g6RKazZKAxeQRTif0Fd01E5hnyugCFVbYMiDS
         t+U7dUXdYDwOHK8xtzKDv/LnRTvqq09vnEy1yDSqhlCufC/oK4fBsNdweDJLdFUPr6fR
         n/isfkZy4NRW/VhAANIUmeWPcAqbE+nni/jKo=
Received: by 10.112.44.1 with SMTP id a1mr4718283lbm.67.1327937794279; Mon, 30
 Jan 2012 07:36:34 -0800 (PST)
Received: by 10.112.40.70 with HTTP; Mon, 30 Jan 2012 07:35:54 -0800 (PST)
In-Reply-To: <20120127210936.GC3124@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189367>

On Fri, Jan 27, 2012 at 15:09, Jonathan Nieder <jrnieder@gmail.com> wrote:
> The unfortunate term here is "existing branches", which seems to have
> been intended to refer to refs that have already been populated in
> this fast-import stream by a "commit" or "reset" command, rather than
> any old ref that already exists in the repository.
>
> In other words, instead of "existing branch", the manual should say
> something along the lines of "branch already in fast-import's internal
> branch table".

Looks sane.

-- 
Cheers,

Sverre Rabbelier
