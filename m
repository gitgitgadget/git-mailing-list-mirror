From: Jeremy Morton <jeremy@configit.com>
Subject: Re: git push default behaviour?
Date: Wed, 14 Mar 2012 13:12:48 +0100
Message-ID: <CAFsnPqrU7fzybncyhY35iAjjQWpAiW_Y2YAW8ExP6Qrxfbu_Cw@mail.gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<m3sjhjs4z5.fsf@localhost.localdomain>
	<CAFsnPqqJt13gDp2RNiEU4dt59iMwFvMzysfk51mO8aF+_nYGXA@mail.gmail.com>
	<201203131627.30455.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 13:12:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7n4Z-0007t9-Fj
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 13:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760878Ab2CNMMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 08:12:51 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60533 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760875Ab2CNMMt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 08:12:49 -0400
Received: by lbbgm6 with SMTP id gm6so754367lbb.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 05:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=f7O1vpIAlxAVbO9Sc4x0glaXU56rrXHdD8qJaEO4Oco=;
        b=YWT7cY8mjnGkOWfmQKgPnIgWiwlKxsIfMY5NpuF2/6phx72HQA2BEjcP6kU32o+WdS
         dzE8bGNXf/DW/Q/lV4c5EjghFwwm5TeNeNPr2qvgXWX8S8bRPkhVjODmON3GHbmVadv/
         gy2QJijAhsElLK63Mz26dIrN697Mtn3c0eNoUlxBLRq1a1KuSKzW/fZ1YCYuG6MRgFiV
         S7yD3MRjS7BW19D0WsDk7pHv9lB+9/bZwVPFYbBT0kIZWX6zwO98HjxuP4kt+xv3toxX
         H04F3EwaoNky3wtIiEl55kkKxQ9zLfMI9CvFCh+OS1XeR3VfUc3ccILJPo3YQ0B4spIc
         Zm6Q==
Received: by 10.112.87.225 with SMTP id bb1mr817655lbb.59.1331727168120; Wed,
 14 Mar 2012 05:12:48 -0700 (PDT)
Received: by 10.112.23.225 with HTTP; Wed, 14 Mar 2012 05:12:47 -0700 (PDT)
In-Reply-To: <201203131627.30455.jnareb@gmail.com>
X-Gm-Message-State: ALoCoQlwu8rD8uq+d6qpdVZJ1+IqAPbsYbqGUhYH+oP2/tKKFRJAfx01WYlrnneXmKIXX+exjvCf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193098>

Would that deny non fast-forwards for all branches, though, or just
selected ones?  We'd like to just to it for 2 of our branches.  We'd
also like to explitly ALLOW fast-forwards to master, when we want to
merge in from develop to master.

A better description of what we want is to prevent 'rewriting of
history' for some of our branches.

Best regards,
Jeremy Morton (Jez)

On Tue, Mar 13, 2012 at 4:27 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 8 Mar 2012, Jeremy Morton wrote:
>> On Thu, Mar 8, 2012 at 11:33 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>
>> > You can always configure server to refuse forced pushes.
>>
>> We're using github, and as far as I'm aware, there's no way to
>> configure github to do that.
>
> It would be nice if GitHub supported setting receive.denyNonFastForward
> and receive.denyDeletes (the receive.*current* do not matter for GitHub).
> Though I am not sure if it would not require changes to the custom Git
> implementation they use...
>
> --
> Jakub Narebski
> Poland
