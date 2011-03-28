From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git fast-import --export-marks flag
Date: Mon, 28 Mar 2011 09:25:01 -0700
Message-ID: <AANLkTinpZ=PjGpFozCAWscfms6uWBSO2y+XqCGGqB2KP@mail.gmail.com>
References: <4D90B457.9040607@codicesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "psantosl@codicesoftware.com" <psantosl@codicesoftware.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 18:25:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4FG8-0002nY-1O
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 18:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897Ab1C1QZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 12:25:31 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62494 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab1C1QZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 12:25:26 -0400
Received: by vws1 with SMTP id 1so2414754vws.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 09:25:26 -0700 (PDT)
Received: by 10.52.98.166 with SMTP id ej6mr5607565vdb.72.1301329521556; Mon,
 28 Mar 2011 09:25:21 -0700 (PDT)
Received: by 10.52.164.105 with HTTP; Mon, 28 Mar 2011 09:25:01 -0700 (PDT)
In-Reply-To: <4D90B457.9040607@codicesoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170150>

On Mon, Mar 28, 2011 at 09:16, psantosl@codicesoftware.com
<psantosl@codicesoftware.com> wrote:
> git fast-import --export-marks is able to export to a file the marks and
> its associated commit hashes created during import.
>
> So far I've seen the marks are not the ones provided in the input but
> some "internal ones" not related with the input.
>
> Wouldn't it be much better, for import/export interop, if it kept the
> original marks?
>
> It would be certainly easier to do incremental import/export with
> external systems not dealing with SHAs...

I don't know what you are looking at, but fast-import uses the same
mark numbers that were supplied in the input stream inside of the
exported marks file. Otherwise as you pointed out, the marks are
useless.

-- 
Shawn.
