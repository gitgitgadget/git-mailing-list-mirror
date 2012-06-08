From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: show refs points to a commit
Date: Fri, 8 Jun 2012 21:51:06 +0200
Message-ID: <CAN0XMO+FpCWgf96ffZ0qd7TNEmdBXicvvk23fnXBaTK_7weV-g@mail.gmail.com>
References: <CAN0XMO+G6K0FZgu35OuuqGEp322vLpakXHXBTPpUQmoex68srA@mail.gmail.com>
	<4FD256CC.5010801@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Fri Jun 08 21:51:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd5DG-0001MF-Bt
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 21:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933615Ab2FHTvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 15:51:10 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36797 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933436Ab2FHTvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 15:51:08 -0400
Received: by wgbdr13 with SMTP id dr13so1201285wgb.1
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 12:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=f3WkjXq/hKTJQwHPet5sgZh95/dWwMFRz28cBbPjRWU=;
        b=mrEoYFd3J27JhFFeNOsh2td9ymyf9jf1ZTjk2hgbf3kB6BJx9E9R3LzTMMK+ngashv
         q2fah0y+Pu1PqLxmMB2fG4qQTHR8t2AX+2Smm52yN9BG3MdeUUz9oCseXVJBXxWTVrb6
         89rYmfgEjq6J+F2lT5pWhNVTFKV/yPeiN8sVdZFP5ZXdsXRqXWWd4oBPVCwYMc02d8d9
         j5OMGfPndeyIaDpZhQTuXATB86xwc8rFWFmAXCV6g8Le2Jdsyzh3hFh9BozV7xmzHv/c
         JNqSxE0hacel/ocCYPxdYEvuVzxeVOJhOjlHw1YwtJfHiEEUElMbIAJ5k95m2ULTETCD
         RrKQ==
Received: by 10.216.145.97 with SMTP id o75mr1994169wej.7.1339185067024; Fri,
 08 Jun 2012 12:51:07 -0700 (PDT)
Received: by 10.194.0.132 with HTTP; Fri, 8 Jun 2012 12:51:06 -0700 (PDT)
In-Reply-To: <4FD256CC.5010801@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199522>

On Fri, Jun 8, 2012 at 9:47 PM, Vincent van Ravesteijn <vfr@lyx.org> wrote:
> Is this what you mean ?
>
> $ git rev-parse master
> f623ca1cae600e97cb0b38131fdd33e4fb669cf8
> $ git name-rev f623ca1cae600
> f623ca1cae600 master
> $ git name-rev --refs=refs/heads/* f344333cd
> f344333cd master~10
>

I just want to know what's the refs where
the *tip* points to my specified commit.
