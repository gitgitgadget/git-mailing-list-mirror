From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 09/15] remote-testgit: exercise more features
Date: Thu, 22 Nov 2012 00:35:12 +0100
Message-ID: <CAMP44s0YPEw-8s4hcVGWWwVj62O1mMWQ4Rh2ZmeRMBXQwPJQxQ@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-10-git-send-email-felipe.contreras@gmail.com>
	<7vhaoi3h0v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 22:34:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbePK-0001rY-Fs
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 22:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917Ab2KVVdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 16:33:46 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57900 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176Ab2KVVcT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 16:32:19 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so8443998obb.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 13:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HaIzYICkhD6Zhq4hZ1MhX5DHDTUQ6nlDhv8tTdrHP68=;
        b=TFD4t3bbip1azwKmRQ1OCKioXLfhTraX1QbRTQCikH9u/OkhqeDncPXSn2hmAKpgVT
         oapyapPPic2XZJeVTnOi9gxYTAzcABLmlUZWNoc7TQWPVuO9d5T4sVlZI/YRtrEgV8Dj
         GXlB+6D3MIOcYWpYavsX0xn5CUcvm+gWnmNyKiTbhPYX4e8y2080er+WKXYgPpqkChUX
         DwZbt7xpTqw+NUq33zhwpn4ZToRGuy/TmYsWwH87/cg5IjIBV1rGNeMG7j1gyNJI4hfs
         U6pU0wgKG8X76aasTgxkWO6bJ5C0z67zNArjoeuo2E1h60CPn67D6mCOBBDX0F9+wlxY
         L02w==
Received: by 10.182.98.19 with SMTP id ee19mr17514062obb.90.1353540912118;
 Wed, 21 Nov 2012 15:35:12 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Wed, 21 Nov 2012 15:35:12 -0800 (PST)
In-Reply-To: <7vhaoi3h0v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210212>

On Wed, Nov 21, 2012 at 7:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Unfortunately they do not work.
>
> As far as I can tell, "more features" simply mean one, no?  Perhaps
>
>     remote-testgit: exercise non-default refspec feature

It's the other way around, a good refspec works, anything else
doesn't. s/non-default/default/ but there's other stuff:

1) *:* refspec
2) no refspec
3) no marks

-- 
Felipe Contreras
