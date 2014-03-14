From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Git Config pushInsteadOf is not working
Date: Fri, 14 Mar 2014 14:42:01 -0400
Message-ID: <CABURp0qdq_Ch0bpz82707iEOQ2catCUWF_dbc6T_q=qF03ypMw@mail.gmail.com>
References: <f6c69381-0f8d-4a91-8593-e1c915171718@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Repo and Gerrit Discussion <repo-discuss@googlegroups.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Raf <rafeah.rahim10@gmail.com>
X-From: repo-discuss+bncBDYMHBPJ3QORBDM3RWMQKGQEKTBHXSI@googlegroups.com Fri Mar 14 19:42:24 2014
Return-path: <repo-discuss+bncBDYMHBPJ3QORBDM3RWMQKGQEKTBHXSI@googlegroups.com>
Envelope-to: gcvr-repo-discuss@m.gmane.org
Received: from mail-lb0-f183.google.com ([209.85.217.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <repo-discuss+bncBDYMHBPJ3QORBDM3RWMQKGQEKTBHXSI@googlegroups.com>)
	id 1WOX3o-0001Nr-6x
	for gcvr-repo-discuss@m.gmane.org; Fri, 14 Mar 2014 19:42:24 +0100
Received: by mail-lb0-f183.google.com with SMTP id q8sf165825lbi.0
        for <gcvr-repo-discuss@m.gmane.org>; Fri, 14 Mar 2014 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=ayXEsv+PGGW02tA7jwOBPQCwqIABWUiDyV9SaondVKM=;
        b=jcef+aGL/L57GnMnAB1YosEhjE8LTNk7ijW+vQ0y7G3BjRnIK9QMVdH49Vbcn88gN/
         zvcIijjyB8Qi1dNHkdWZKjmCeqnCHF5Fhuld+0G+jdEanZcV+dp4CT3G9Ahik9MbG3PT
         B0n2ge5VKZE4MEDYmnv5a/XmiXAZ7XgO4JygrUwHNG7kkRCMFG6ygZPYIL/ArQWSKQ+4
         TY+wcj7PeofrFxy3rslnOhlGWwQQ4Eij+in1glLOttSvguv/hojGnmokmf9uAZUTSA61
         hdbP0QA68jSTn70HLMgYYl0XmAVcTl+HOlws4PlPgiySJYcfg937t/pkia0SPrHcl7Yp
         Jsqg==
X-Received: by 10.152.183.35 with SMTP id ej3mr22904lac.15.1394822544013;
        Fri, 14 Mar 2014 11:42:24 -0700 (PDT)
X-BeenThere: repo-discuss@googlegroups.com
Received: by 10.152.37.163 with SMTP id z3ls10350laj.66.gmail; Fri, 14 Mar
 2014 11:42:21 -0700 (PDT)
X-Received: by 10.112.162.193 with SMTP id yc1mr1801812lbb.19.1394822541413;
        Fri, 14 Mar 2014 11:42:21 -0700 (PDT)
Received: from mail-wi0-x229.google.com (mail-wi0-x229.google.com [2a00:1450:400c:c05::229])
        by gmr-mx.google.com with ESMTPS id i3si164613wib.0.2014.03.14.11.42.21
        for <repo-discuss@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Mar 2014 11:42:21 -0700 (PDT)
Received-SPF: pass (google.com: domain of phil.hord@gmail.com designates 2a00:1450:400c:c05::229 as permitted sender) client-ip=2a00:1450:400c:c05::229;
Received: by mail-wi0-f169.google.com with SMTP id hm4so79649wib.4
        for <repo-discuss@googlegroups.com>; Fri, 14 Mar 2014 11:42:21 -0700 (PDT)
X-Received: by 10.180.101.166 with SMTP id fh6mr7452816wib.2.1394822541293;
 Fri, 14 Mar 2014 11:42:21 -0700 (PDT)
Received: by 10.227.147.3 with HTTP; Fri, 14 Mar 2014 11:42:01 -0700 (PDT)
In-Reply-To: <f6c69381-0f8d-4a91-8593-e1c915171718@googlegroups.com>
X-Original-Sender: phil.hord@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of phil.hord@gmail.com designates 2a00:1450:400c:c05::229
 as permitted sender) smtp.mail=phil.hord@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list repo-discuss@googlegroups.com; contact repo-discuss+owners@googlegroups.com
List-ID: <repo-discuss.googlegroups.com>
X-Google-Group-Id: 540870184241
List-Post: <http://groups.google.com/group/repo-discuss/post>, <mailto:repo-discuss@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:repo-discuss+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/repo-discuss>
Sender: repo-discuss@googlegroups.com
List-Subscribe: <http://groups.google.com/group/repo-discuss/subscribe>, <mailto:repo-discuss+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/repo-discuss/subscribe>, <mailto:googlegroups-manage+540870184241+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244103>

I thought you had the URLs backwards, but that doesn't seem to be the
problem, assuming I am reading your transcription correctly. Maybe the
'insteadOf' is being applied in addition to (and cancelling out) the
pushInsteadOf.  Does it work as expected if you remove one or the
other?

In any case, it sounds like a Git issue, not a Gerrit one. You should
ask on git@vger.kernel.org, which I have cc'ed here.

Phil

On Tue, Mar 11, 2014 at 4:44 AM, Raf <rafeah.rahim10@gmail.com> wrote:
> Hi All,
>
> I have been searching high and low for this issue, but somehow I do not see
> anyone encountering the same issue as me.
>
> Here is the scenario:
>
> I have created a local mirror for my group of developers to download the
> AOSP code from an external gerrit server.
> So the developers will download the code from the mirror but push to the
> external gerrit server.
>
> Hence, I have edited my /home/user/.gitconfig file to add the following:
> #To download from
>         [url "ssh://localMirror"]
>         insteadOf=ssh://gerritServer
> #to push
>         [url "ssh://gerritServer"]
>         pushInsteadOf = ssh://localMirror
>
>
> Some how, the pushInsteadOf does not work, when i tried to push the changes
> to the external gerrit server, it still pushes to the local mirror server.
>
> Also, when I tried to manually add the remote to the repository: git remote
> add gerrit_origin ssh://gerritServer
> I tried to push to the gerrit_origin, it still pushes to the local mirror
> server. Which is strange..
>
> Please help. I have spent whole day looking for this solution to no avail.
>
> Thanks.

-- 
