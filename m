From: Stefan Beller <sbeller@google.com>
Subject: Re: Saving space/network on common repos
Date: Wed, 17 Dec 2014 14:01:55 -0800
Message-ID: <CAGZ79kbupVyX=SUSbuAbkX5nA2NJC1R5zCzoVz4-Rdkcc+Xt1Q@mail.gmail.com>
References: <CAGXKyzEYhR69w1=4q-xtBagVBwOPqNA9C=AD0bAorB+5eRtVRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: csilvers@khanacademy.org
X-From: git-owner@vger.kernel.org Wed Dec 17 23:02:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1MfR-0005g3-5t
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 23:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbaLQWB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 17:01:56 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:64477 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbaLQWB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 17:01:56 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so15870742ieb.40
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 14:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fhKjSZiIVisDOJarcTZsfBeyZgeIt8qx28sghsA0zLQ=;
        b=UxYNTx80hR3wObwM2ucatgRaET4fZtnUkeaqfO5E33CMBT6a6dK/5s/G2rvYuZc59R
         59K7PXmw0vwxWmgIGdCdQVaP5p2i2weFg1IuE2fmfpMkWBT4kdYDQUxxu2w5KI69eJ2C
         4syBm2N54OpAuAu6cd3621BEpDb4vmUAcqTYGIfXfHZ8hF5oG3rGHREoWCh/FpYFyLO2
         r0yKy0iqszjVq7JG6kOofGukudJ8KJFBia1s1im8rQzg8rbPytuX4zQLRcw0TUmkZrag
         uvKjBPP89pWg5ACRtys359dDYaOOV3mgWACLsTrh0mV0+LK1n30j6IJnnmczkIWP/BSj
         2t9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fhKjSZiIVisDOJarcTZsfBeyZgeIt8qx28sghsA0zLQ=;
        b=hX3OcxCxwEd9MAgkeD2gI0CYw/dkk+uApo9+34q84P16zITa/MiIQKDM2FC+sI1G7Y
         Op1z4KIyc9cWbr9HNJXlAl9is7baXuVdjRGwbtCDBGweJg3dVTDtKo/JStIYKMiiUc+q
         rXvUpQy8cZSuao8x0jjOYTPGsWNIDxgo3E/+LVjZAVddsIF9bIIXFAapYIpC0dQrh8PR
         HQEXbUCQFOJOkSItYpiRzScCwT4Wnck/UewyZhMtdJygo8Cbi6KDIeFyA+qsPN3E0SyS
         sXqwwy2obZYpfqzmOtgz8OmwhN3q+k3z3epi9bQopivVlC7HDTGo6xGbEJMTkQnjg50o
         8XsA==
X-Gm-Message-State: ALoCoQnWzVkCqFVpU1biCEgFzbhkBNePtt51xoZ3M+w2ijqAXgS2NnEXOOKeLgVgFPHomCZoB2eD
X-Received: by 10.50.117.41 with SMTP id kb9mr1353307igb.37.1418853715382;
 Wed, 17 Dec 2014 14:01:55 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Wed, 17 Dec 2014 14:01:55 -0800 (PST)
In-Reply-To: <CAGXKyzEYhR69w1=4q-xtBagVBwOPqNA9C=AD0bAorB+5eRtVRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261498>

I am not sure if there was any improvement since then, but Junio
wrote about alternates 2 years ago
http://git-blame.blogspot.com/2012/08/bringing-bit-more-sanity-to-alternates.html
