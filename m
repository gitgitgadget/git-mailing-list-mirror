From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2 v4] tag: support configuring --sort via .gitconfig
Date: Wed, 16 Jul 2014 07:55:47 +0700
Message-ID: <CACsJy8DOB1Uic=p+aP6T4LNbS5X9XUaBN-2qC1ZyC0XqeeGOuQ@mail.gmail.com>
References: <1405036334-8093-1-git-send-email-jacob.e.keller@intel.com> <1405036334-8093-2-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 02:56:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7DWC-0004yx-QY
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 02:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759808AbaGPA4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 20:56:21 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:36790 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759245AbaGPA4T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 20:56:19 -0400
Received: by mail-yh0-f49.google.com with SMTP id z6so110446yhz.22
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 17:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oQ53Dib9rdmlZ5YPIsNWNdysmVjJ9mERmDp24Lp9W5k=;
        b=uPCvp9cJif49+WTnjZp6oOcZMNQGWgMLHAGI5YvrAWR3CUZH3QeLF9NPwEV2xOdFQh
         eF2peEij3SDF6Rxt1A9SKhN4Zoc1Xx+Qkpmwh3wk2F8pRK/x1auE8ImqdJdn2JWof/EV
         fm5ncziH7XEUFvB9+YtxFzCbGubBJx9uk7wWK757kRNwZ/4Hp4toBDPbRKjyLSe9fezD
         kYlDcYFxkOIo0wz5GhZI375FGyFeiDHLtTKILsUJKF2nMresGNRb8eC8MJzi+614t7Cy
         NYj/L84knYGMCYSPX1iDoiAqKsHacq+zyJz4D9R+tbLZYfxEajNrWKHLAFupEqtv6esx
         Pq/g==
X-Received: by 10.236.157.138 with SMTP id o10mr1286716yhk.48.1405472178575;
 Tue, 15 Jul 2014 17:56:18 -0700 (PDT)
Received: by 10.170.233.7 with HTTP; Tue, 15 Jul 2014 17:55:47 -0700 (PDT)
In-Reply-To: <1405036334-8093-2-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253653>

On Fri, Jul 11, 2014 at 6:52 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> Add support for configuring default sort ordering for git tags. Command
> line option will override this configured value, using the exact same
> syntax.

Kinda off topic, but I wish we could show these default overriding
settings when GIT_TRACE is set. E.g. if this knob is set, GIT_TRACE
would show 'git' 'tag' '--version=....' even though --version is not
specified from command line. Or some other way to know which knobs are
active when a command is run.
-- 
Duy
