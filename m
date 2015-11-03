From: Konstantin Khomoutov <kostix+git-I8vNd4LC5SeHXe+LvDLADg@public.gmane.org>
Subject: Automatic download at git-scm.com does not work (Was: 
 Cant download Git)
Date: Tue, 3 Nov 2015 16:14:28 +0300
Message-ID: <20151103161428.a6be2380032c2d07c1769507@domain007.com>
References: <025c4d3a-f018-4e13-9fc8-7649460662cd@googlegroups.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: M Hendrickson <mkckkcm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: git-users+bncBCWKX34CSUCBBN7G4KYQKGQETCVJ5HQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Nov 03 14:14:34 2015
Return-path: <git-users+bncBCWKX34CSUCBBN7G4KYQKGQETCVJ5HQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-lf0-f61.google.com ([209.85.215.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCWKX34CSUCBBN7G4KYQKGQETCVJ5HQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1ZtbQ1-0003wi-1r
	for gcggu-git-users@m.gmane.org; Tue, 03 Nov 2015 14:14:33 +0100
Received: by lfu67 with SMTP id 67sf4460151lfu.0
        for <gcggu-git-users@m.gmane.org>; Tue, 03 Nov 2015 05:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-spam-checked-in-group:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=1n2EwOkDLlB6UtnGhEoxkH7SNw4KlJa6Iiqkl0iUdZI=;
        b=PdmQpasX0VM0lMNm5JZA5D4j9fT8OC8c21BC6zZ7hQwof/H9tFHjCkWTooTWwTBmh/
         hS2M+BpZvD3YLyQi3eLRNHak/ru7nGwsCAS+mIiAcDsEkHhrxkdM657TZtTmqMt+4WtK
         5O5AkZ5+4oquJdRYHp1nLfKp1jnhOewGBYmC/ZfxoKBP59dxaVHvfLOXEzaHYvKMebp2
         kMkV4HY8zCzruG9+UaUR3PPMZfX7MhReALFQhGyQVdtzvuHkU6GBebuVhDAL72izDsGD
         SF2zpxLelgQMRYnFsKDtzS3SG0xxXdU8OT8FifKh1yV6UuJVorWQILFYZG/J/Hn5+mcF
         9xUg==
X-Received: by 10.28.9.209 with SMTP id 200mr77898wmj.15.1446556472839;
        Tue, 03 Nov 2015 05:14:32 -0800 (PST)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.28.146.133 with SMTP id u127ls863920wmd.2.canary; Tue, 03 Nov
 2015 05:14:31 -0800 (PST)
X-Received: by 10.28.173.83 with SMTP id w80mr3474706wme.0.1446556471513;
        Tue, 03 Nov 2015 05:14:31 -0800 (PST)
Received: from mailhub.007spb.ru (mailhub.007spb.ru. [84.204.203.130])
        by gmr-mx.google.com with ESMTPS id wn2si188943lbb.0.2015.11.03.05.14.31
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 03 Nov 2015 05:14:31 -0800 (PST)
Received-SPF: pass (google.com: domain of kostix+git-I8vNd4LC5SeHXe+LvDLADg@public.gmane.org designates 84.204.203.130 as permitted sender) client-ip=84.204.203.130;
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id tA3DESJt019478;
	Tue, 3 Nov 2015 16:14:30 +0300
In-Reply-To: <025c4d3a-f018-4e13-9fc8-7649460662cd-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
X-Original-Sender: kostix+git-I8vNd4LC5SeHXe+LvDLADg@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kostix+git-I8vNd4LC5SeHXe+LvDLADg@public.gmane.org designates 84.204.203.130 as
 permitted sender) smtp.mailfrom=kostix+git-I8vNd4LC5SeHXe+LvDLADg@public.gmane.org
Precedence: list
Mailing-list: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact git-users+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <git-users.googlegroups.com>
X-Spam-Checked-In-Group: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-Google-Group-Id: 934228491576
List-Post: <http://groups.google.com/group/git-users/post>, <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/git-users
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/git-users/subscribe>, <mailto:git-users+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+934228491576+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/git-users/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280794>

On Tue, 3 Nov 2015 04:55:22 -0800 (PST)
M Hendrickson <mkckkcm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> I am trying to download Git. When I click download for Mac OS X it
> says "download starting" but the download doesn't start.
> 
> There is a manual download option from sourceforge. But some have
> warned me that downloading from sourceforge often contains unwanted
> things included in the download.

That was a blunder of the (recent) past so I'd say it's OK to download
directly from SF.  Note that the Mac OS X build accessible from
git-scm.com, while being "officially blessed" is not prepared by the
upstream Git developers (as they only distribute the source code) but
rather this is a port coordinated there at that SF project you referred
to.

Well, I've just verified that what would be automacitally downloaded
has the same URL as that "download manually" link.
So you should be fine with the manual download.

> Does anyone know why the download from git-scm.com is not working?

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
