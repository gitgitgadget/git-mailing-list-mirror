From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Will git have a baseline feature or something alike?
Date: Mon, 3 Mar 2008 10:29:37 +1300
Message-ID: <46a038f90803021329g29b19234wab6b626c9d47e7ab@mail.gmail.com>
References: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com>
	 <m3tzjrkie4.fsf@localhost.localdomain> <47C8FFFC.3050901@vilain.net>
	 <200803011339.50978.jnareb@gmail.com> <47C95823.5090006@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"eric miao" <eric.y.miao@gmail.com>, git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Mar 02 22:30:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVvlB-0000LC-MQ
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 22:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757394AbYCBV3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 16:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757087AbYCBV3j
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 16:29:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:33391 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756906AbYCBV3i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 16:29:38 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1599909ugc.16
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 13:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=E9fWM1y1aN2ZU6jqKhnK+88ZvSLfqk2zDiJga4BtNA0=;
        b=DjfBZohtgCQDymBfvKbIh68tsaAaL91xHp9SoaS0htU5W6VN61G9J0ZfB5eEEdoP9vWVK2cQPWklzdb1681TpEooay2+P9g4qlnQxs9dThyCW3PF7eOy1Li+aW6bx31830163z9n8zG1aFhVLrozGBRw5yYuGF8L2w7HLuL/DN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oIgjdt/6lGgTPUkU5y0bfTf7CJHpHYHpc8nN9Hj6Fj6+a5Pp8MCW3y8ppcW4pYUo8QNob6UWjXmD5CB4gVMIuN6tjE7MlGyuSYJbYwAyg7ts4WJCf8V9kye1umAaG67Y0ZUJZLp/V4wPj/YxhrJvuO//8VhZz3QyRtGNNkqBKIU=
Received: by 10.66.255.7 with SMTP id c7mr4143796ugi.43.1204493377197;
        Sun, 02 Mar 2008 13:29:37 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Sun, 2 Mar 2008 13:29:37 -0800 (PST)
In-Reply-To: <47C95823.5090006@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75845>

On Sun, Mar 2, 2008 at 2:20 AM, Sam Vilain <sam@vilain.net> wrote:
>  > And last, KDE repos should most probably be split into submodules.
>
>  Mmm.  Everyone always says that; what it really needs I think is someone
>  to really take the conversion on board and come up with a workable plan
>  on this front.  I think the counter-argument to this was "but you always
>  want to have 70% of the repository checked out for development".
>  Counter-counter argument is "yes but they don't always need to be deep
>  clones".  Anyway, it's not my baby, just thought I'd let you know about
>  it :-)

That sounds a lot like the x.org submodule split. AFAIU, it did
involve some relatively minor changes to configure/build scripts to
handle the submodules being built somewhere other than in a subdir of
the main project. Nothing earth shattering, just small changes to how
the build works, and I think after the initial shakeout everyone's
happy and the development pace is quite a bit faster & more
adventurous.

All of this from bits I read in the x.org dev lists, and some
developer blogs - IANAX.OD

cheers,


m
