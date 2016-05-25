From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: Please add a git config option to make --show-signature the default
Date: Wed, 25 May 2016 23:48:57 +0530
Message-ID: <CA+DCAeSqTitycrO2y=SdutK1H2+jbzp7OzbhZ3pOYY_YOdOkGw@mail.gmail.com>
References: <57438568.60707@gmail.com>
	<alpine.DEB.2.20.1605241313440.4449@virtualbox>
	<CACC5Q1c2s4yOtGAtKsepwnme7udq7yqyN7S5BfMHbi0L08XwzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Austin English <austinenglish@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 20:19:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5dOc-0005Bd-UM
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 20:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791AbcEYSTC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 14:19:02 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35095 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763AbcEYSS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 14:18:59 -0400
Received: by mail-qg0-f44.google.com with SMTP id e93so25846389qgf.2
        for <git@vger.kernel.org>; Wed, 25 May 2016 11:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Xa/W4JT0Qa6K3/af32GTAi1u/kkmWC6hcseKGYzkGdw=;
        b=h2xPCtMOQc6jjC+OHEEFC6bJ2d8zytGSSH3Cmyzkp9Yq5VVgE36XvP5GTaACc/lDay
         74kUwN4cxCfjZeox0fENIstWKeAUMVMcQ7kDCy9ycBwV6Lc6o9Z6qjEPbpMljPIipB7f
         5qR7ME3zhv/gKr/QJRYq7MEs5Lr0hfNhi6w4hfNysmIVv3Ebge7AlZeS193H3PS8MTdd
         Ah7zv/08qAMQpmep2RlP7u8AAvOJv4m1lEc6gfBB59TOHjOxnTSrhyb+2v9smx6I6VvF
         IG8McBaDjsLtAK10YP8ciQMWNOeWc1IVzat9jMfuu1VW56UELhYREH5BGGyCzpHdMh+5
         JN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Xa/W4JT0Qa6K3/af32GTAi1u/kkmWC6hcseKGYzkGdw=;
        b=hEwRMkh+gBCddUXcsvSUROn6E2aWjCqPFieO//2joghipAiPZ0te6SU4MMiDKuAWFE
         sukZntZUGbG4jObzUp4ZJZsM8t8rOM+blh61mLSll7jhtCh7NqnOewiUKv0hMKq7FJ3l
         Cz0isn+OfworWskHw6bxrYYk8uLm62CNb39A0BkRgfe0cgKkePXmO7XrS2iuzgLiiBug
         Zpk3/TqISGNN5kLgi7NPZf/a0LKuj1RE0ANz5JarAobedGfA54eHYf4Pzu9hgKybNy1T
         YSQycQpaUS6kjcvbYOYJ++XHTklE6Yh4S1PI2qxyd/HcrPL2ud7b/rdJWDL3O3ZKYHjz
         CreQ==
X-Gm-Message-State: ALyK8tI4ufDYF+y2TZQy0Cnd7kgahRd389PM33YHVg36PO4yJQbw0MPBZ1OQ8zoPp+wSsVZITRrK5/0LY5ZPCw==
X-Received: by 10.140.109.10 with SMTP id k10mr4848224qgf.89.1464200337894;
 Wed, 25 May 2016 11:18:57 -0700 (PDT)
Received: by 10.55.51.212 with HTTP; Wed, 25 May 2016 11:18:57 -0700 (PDT)
In-Reply-To: <CACC5Q1c2s4yOtGAtKsepwnme7udq7yqyN7S5BfMHbi0L08XwzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295584>

Hi,

On Wed, May 25, 2016 at 9:28 AM, Austin English <austinenglish@gmail.com> wrote:
> I'll try
> to submit my own patch. In the meantime, it seems appropriate to file
> a bug so that others can have the opportunity to solve the problem if
> they're interested.

If you haven't started working on it and if no one else has picked it up
then I would like to try it out and submit a patch.

Thanks,
Mehul
