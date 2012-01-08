From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/6] revert: allow mixing "pick" and "revert" actions
Date: Sun, 8 Jan 2012 13:40:14 -0600
Message-ID: <20120108194014.GI1942@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 20:35:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjyWQ-00022Z-6D
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 20:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab2AHTfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 14:35:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37215 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212Ab2AHTfG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 14:35:06 -0500
Received: by iaeh11 with SMTP id h11so5657042iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 11:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QV9p/ZlKIubhURakyGog/XvXHPH+0E+r1GxdgSeVMrk=;
        b=UoMHdd2paUWteF5Cn3lYcW+bggCRXE/yZrDDyXLqN62xTuzgkWecjOi9KxK0FatCsa
         W6U0BKi+M3Z9wmaQD82nk4dCIhvcduqDrz9yAOpQY9XnaZtb6X/y+7uv/dqDMwb5mA81
         WUAtH2PxhafM65BiecSViTZPhN+4xIuVgRTCA=
Received: by 10.50.42.167 with SMTP id p7mr16336259igl.20.1326051306205;
        Sun, 08 Jan 2012 11:35:06 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 36sm241720624ibc.6.2012.01.08.11.35.05
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 11:35:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326025653-11922-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188119>

Ramkumar Ramachandra wrote:

> Parse the instruction sheet in '.git/sequencer/todo' as a list of
> (action, operand) pairs, instead of assuming that all lines have the
> same action.

Yes, I've always liked this one.

Haven't re-read the patch to avoid wasted effort if there are changes
when the previous patches in the series change.  Maybe it would be
possible to send as a standalone?
