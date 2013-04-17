From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git crash in Ubuntu 12.04
Date: Wed, 17 Apr 2013 17:26:50 +1000
Message-ID: <CACsJy8AfVjhsBtfwJomRmoYsA3EMPja--y5Twq=T7-bCUQRU-w@mail.gmail.com>
References: <CAJiNi_FfU9Gsr2D9CcC0wWwgO1oKBXwxp87-wBUJBU2kyGaQNQ@mail.gmail.com>
 <87mwt6ltia.fsf@linux-k42r.v.cablecom.net> <CAJiNi_EgjgKs7oNJyGcamUFz=ARDAuBTb+bJ0uVsPFBMbZF3YA@mail.gmail.com>
 <20130411170659.a35d2c581cf34ade13448bfa@domain007.com> <CAJiNi_Gju2aJkVJJmoxnEAubfPvjaVhVF6DisaLn5kUJ3YRD=w@mail.gmail.com>
 <20130412180525.aa5b8eacd691a427244d6ab5@domain007.com> <CAJiNi_GQZf8BRkTR8+j6YjdcqUH1J1NATSrNUjZ=65V+ip6okQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Sivaram Kannan <siva.devel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 09:27:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USMm5-0004kJ-UP
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 09:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758381Ab3DQH1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 03:27:21 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:58883 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758348Ab3DQH1U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 03:27:20 -0400
Received: by mail-oa0-f45.google.com with SMTP id o17so1184781oag.32
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 00:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=sYgsbb957NZ1EBRLeO+yTlDAYCgIZXCrW6+Op7BAXNw=;
        b=CBXJ0Ld2lAYHqpz3Gd2srrhFDS53J6SbzXBDpGL1GIRQ/DWFKcWn/LBDbSmi1TU8dH
         cA/e8LWHD9mjVc0Ez7fepGrQB0wfBWosf9C3MAuq6RHZfCZ8ne743OnZhCOjpfb8BPSd
         RWkZgGTRtJxZHtLREw897jX0wUETesPU3DfF4fpGw2e6KjyXjz7dvsTbpjpi7EU96jrB
         R1Ofc0KuDkpG9sOCNSusSWuK4oXtkPUFb5PFtit+AbMn51EhQFsQ5Y5feQB3gnBm5R8H
         yfVNR+NlVgqClSaOFOwYNfCj+Hc2Wsuys5HTzzmC+iLhXNBC7f/Oezbgx1AQeZrgG+/C
         M9CQ==
X-Received: by 10.60.142.230 with SMTP id rz6mr2159868oeb.22.1366183640206;
 Wed, 17 Apr 2013 00:27:20 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Wed, 17 Apr 2013 00:26:50 -0700 (PDT)
In-Reply-To: <CAJiNi_GQZf8BRkTR8+j6YjdcqUH1J1NATSrNUjZ=65V+ip6okQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221515>

On Wed, Apr 17, 2013 at 4:28 PM, Sivaram Kannan <siva.devel@gmail.com> wrote:
> Got an proper dump from git this time. See whether it helps.

Probably not because there are no debugging symbols. Not sure how
ubuntu packages these symbols..

> I have setup another machine with Ubuntu 12.04 and updated only git and
> ported the repo there, after 200 clones no crash so far.

Any chance you could publish the repository that causes the crash?
--
Duy
