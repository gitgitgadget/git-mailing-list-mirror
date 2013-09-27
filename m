From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] for-each-ref: introduce %(upstream:track[short])
Date: Fri, 27 Sep 2013 21:40:52 +0530
Message-ID: <CALkWK0me+DdxVVjZTi3zmOoCc5HcjR8BgqWMNUkHU1qDP4-vfA@mail.gmail.com>
References: <1380283828-25420-1-git-send-email-artagnon@gmail.com>
 <1380283828-25420-4-git-send-email-artagnon@gmail.com> <C79FDE949E6D43478E1176342FA09E0E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Sep 27 18:11:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPado-0004Hd-QG
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 18:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939Ab3I0QLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 12:11:36 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:64332 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921Ab3I0QLd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 12:11:33 -0400
Received: by mail-ie0-f182.google.com with SMTP id aq17so4470252iec.27
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 09:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=agiWxPIz3Y5h+DtZtX7dKo4nyRFol/6cR7ow5va3cog=;
        b=as9CttGd2hrk8XxUOwTThsdT8XPVzPOEH5R54I52AqrSjmOa0DUFPZie69POik72Kk
         ykKZo73wpy3XS7B7uFNBi87/lJ35xvr1i2XqG2UaE/IvbDwJZytHL7YAOAOSKqz3ZXrM
         eZdTFAXq0kFQdGkkIKrsPMNuaAGEcERu1sEFzLS98Doo+vbygUVZuY5LQ3O8I0X0dumj
         nj1pXS42L4xnC7Mc9h/vO/A4/ehPeP4u1yJdmkPeJc428ZE5CE5BzsFn7E2yi6ZYBa24
         gwH2uJX0GcbT5PiV6AclFAUHs7JK8zGAC3+ghNMzfCvmXNdRfR5Q3s9hbh0Fuk/CDEz2
         T59Q==
X-Received: by 10.50.132.68 with SMTP id os4mr2952125igb.55.1380298292726;
 Fri, 27 Sep 2013 09:11:32 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Fri, 27 Sep 2013 09:10:52 -0700 (PDT)
In-Reply-To: <C79FDE949E6D43478E1176342FA09E0E@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235468>

Philip Oakley wrote:
> "=" and "<>" I can easily understand (binary choice), but ">" and "<" will
> need to be clear which way they indicate in terms of matching
> the "[ahead N]" and  "[behind M]" options.

The ">" corresponds to ahead, while "<" is behind. You'll get used to
it pretty quickly :)
