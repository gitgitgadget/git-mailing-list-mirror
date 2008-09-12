From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH] git-gui: I18n fix sentence parts into full sentences for translation again.
Date: Fri, 12 Sep 2008 14:23:42 +0400
Message-ID: <bb6f213e0809120323l3c18cd32hfde9ef6756593061@mail.gmail.com>
References: <200809121117.39407.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Christian Stimming" <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Fri Sep 12 12:25:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke5pw-0004cw-B1
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 12:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbYILKXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 06:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbYILKXp
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 06:23:45 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:38581 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbYILKXo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 06:23:44 -0400
Received: by yx-out-2324.google.com with SMTP id 8so275975yxm.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 03:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NZUGBmAGtRTLcYML1mq2w/WkzKrSJFtnkXbvdMX+AA8=;
        b=ATff+OIZVGMuuoR9mqYFa1J8IGXJ64d4PaT0a6FLtUaUd3yKqTvvWgT00bEKr/1Z6W
         yg2R4f4uCQVqomzRKw/odqHgE+ab21lPPqlGKi4ICK1WOGG0gUsJ2aLKpVkrylMDs+9c
         pYXxAgaWuTBCftoFcNP3kQpdww3qXkmhw+nZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ppYSvBMUFAurc7gB3DcHcVbLrgEn4G1FmKpvkJwXVzlYnhLxUyIk/aR9hys4R2sbIl
         CGed0dPW8h5eqVqWdnLk8NbLh76G5O4kp8JN9vjzVVYpXn7QWNh4ZglKDfSD6QaVOprz
         nLu2ln7fuSSwBez3VAGoFGlhotsXwKJbYj3dc=
Received: by 10.103.244.10 with SMTP id w10mr2805489mur.67.1221215022859;
        Fri, 12 Sep 2008 03:23:42 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Fri, 12 Sep 2008 03:23:42 -0700 (PDT)
In-Reply-To: <200809121117.39407.stimming@tuhh.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95696>

On Fri, Sep 12, 2008 at 1:17 PM, Christian Stimming <stimming@tuhh.de> wrote:
>-       set op_question [mc "Force resolution to %s?
>-Note that the diff shows only conflicting changes.
>+    set op_question [strcat $targetquestion "\n" \
>+[mc "Note that the diff shows only conflicting changes.
...
> -               $target [short_path $current_diff_path]]
> +               $targetquestion [short_path $current_diff_path]]]

You should remove this $target completely -- there is no %s to match it anymore.

Alexander.
