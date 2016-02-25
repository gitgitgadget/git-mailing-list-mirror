From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv16 0/7] Expose submodule parallelism to the user
Date: Wed, 24 Feb 2016 17:54:12 -0800
Message-ID: <20160225015412.GR28749@google.com>
References: <1456364525-21190-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 02:54:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYl8Q-00006B-Cc
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 02:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758932AbcBYByW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 20:54:22 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34066 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758880AbcBYByV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 20:54:21 -0500
Received: by mail-pf0-f182.google.com with SMTP id x65so23309359pfb.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 17:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sf849YIoGtA9LueqOP7u3GMXoYqb3vMf+ejNZDyNHH8=;
        b=ApsPW0zeli0hc88/as5o5ptSaCrQ7C/JKzxiA2/Ia0vcRFR9+GUPKmPKLTbxhBcc/D
         KcrZEF2ff4PhK24Ev8U0y7UU2hNgtZH36H6RIeY87fFDlOvWWR1P9CDtw3loo6kx9Sjq
         +bRn8tLfePvClfvsZDCLlzEv2fGmYib06cOktq+51vXK5YHRAM8ZkPPC9aJOLum9qEb/
         FwAGMhXU5fYFCO6YdPQuUpHhBR+2GRtGMsCRGode2jMrxcXxcap5o+Z+E+eie9P3m3Dd
         1ULATplAW50aSmkNF0jKwxOkoY+0zMvzDHe62VcBFnpaBHv9wVnxTBFYv+aH/h3WsQfC
         ft6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=sf849YIoGtA9LueqOP7u3GMXoYqb3vMf+ejNZDyNHH8=;
        b=YSg2dAK00gN1qDxZR0ShfoCgGTFdMK94e9G93Y0f6YlT8ct9R6HwlL7ncCBfVI/+JV
         PJ8VH1NS/gBlBhiSG7yjhrQKtaVbvub4oAfhTkiJoNvMoCYRZyHEva46eaarUhfMVjn0
         +X4fLzeQyFYD5pcznN5re+7DYlBAqesV8xPm1qml8w9jG6X0BJty0QnLDci/F6GeFVu3
         zdEa87I9N2tTd7j+ms0yRastPsdh8mDrJtozxsIlDp3bbX5wOskZxUe5JIMX6YMI/H2o
         pjXBs/1YydtPvaSgd1wb0k3c/8crGZS0y2MEVdm5JY/dejcWM6YVMxqLF5RKrcgX4pnV
         xiDw==
X-Gm-Message-State: AG10YOS/I5o0U3fxs0qUhaH8BsYSiMAn48M42W85dxnSoayb5qRJcbsIswa6U7Tm6UTOTA==
X-Received: by 10.98.15.19 with SMTP id x19mr59571543pfi.60.1456365255164;
        Wed, 24 Feb 2016 17:54:15 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:41cf:620e:463d:86cf])
        by smtp.gmail.com with ESMTPSA id l14sm7758404pfi.23.2016.02.24.17.54.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 17:54:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456364525-21190-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287311>

Stefan Beller wrote:

> This build on top of 163b9b1f919c762a4bfb693b3aa05ef1aa627fee
> (origin/sb/submodule-parallel-update~5) and replace the series from there on.

Except for the comments in patch 3,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for writing it and sorry it took so long.
