From: Julian Ibarz <julian.ibarz@gmail.com>
Subject: Updating a submodule with a compatible version from another submodule
 version using the parent meta-repository
Date: Wed, 26 Jan 2011 13:32:33 -0500
Message-ID: <AANLkTimvNaiieEw8-Y52xxDW6DQ6b16v9azCk+BDPxhe@mail.gmail.com>
References: <AANLkTinN1XVsAZXGLqkuhysrJ8-TCtGm4pOu2RfCEVVp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 26 19:32:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiAAa-00086X-8S
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 19:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431Ab1AZScg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 13:32:36 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39580 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab1AZScf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 13:32:35 -0500
Received: by wyb28 with SMTP id 28so1227295wyb.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 10:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=o84K+i4u8g50DqiabnBocloiBnSb8rehVZD1rge5I5I=;
        b=xSMZQL0ivg1smfP5nlQ3ZLq8kY0mQu6Opqi11XLWepaAlQtwc7SG5Q+SiWq9bQlgp+
         Ts+F0LO5JX2jfYfngaa/rWnji3H6EkjLGzA61h30GWZQPk+xdIcyzVyeRzpPM/RFbta4
         s0gdKAxGPzP6Cib6OtA/1fTaWEes85AYYzMhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=x+UKQhumSXZcCxrd4AJ36ZW0+SHLrXHUONKW/r0SjH2Vg6UomfC6Bj7uYyiL74e1vw
         rHxII9vHsFeC+2ebjYPryLDWNCaju23OcRmo/8qnvRnOgwdmSEi08PUI36tcrKk4RNFI
         P7yo2vF0RsCWP0rZHNbiLbemTr7CWPRvHS9J4=
Received: by 10.227.11.143 with SMTP id t15mr3093088wbt.27.1296066754007; Wed,
 26 Jan 2011 10:32:34 -0800 (PST)
Received: by 10.227.146.83 with HTTP; Wed, 26 Jan 2011 10:32:33 -0800 (PST)
In-Reply-To: <AANLkTinN1XVsAZXGLqkuhysrJ8-TCtGm4pOu2RfCEVVp@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165528>

I am using git submodule in one of my professional projects and I am
facing an issue when I am using git bisect in one of the submodules.

Basically I have a meta repository which I will call A and two
submodules B and C. Sometimes I use git bisect in B but it is
dependent on C so when I go back too much in the history of B, C needs
to change its version to a compatible one. Doing this manually is
really time consuming for me and I guess a lot of people have this
issue so I was a little bit surprise to not find easily anything on
the net that permits to do this automatically.

Is there anything existing to do that and I just didn't find it yet?
If not I think I might have an implementation idea I would like to try
out.

Thanks for your time,

Julian Ibarz
