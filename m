From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [RFC] Code reorgnization
Date: Thu, 17 Mar 2016 17:00:03 +0000
Message-ID: <CA+39Oz6jNwcyCQFiakh=Ech6p8UYRW9pn95e6cTGXf8nFcwwWQ@mail.gmail.com>
References: <20160317111136.GA21745@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 18:00:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agbHp-00082s-Sm
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 18:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031658AbcCQRAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 13:00:21 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33446 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031652AbcCQRAU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 13:00:20 -0400
Received: by mail-wm0-f49.google.com with SMTP id l68so34953271wml.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 10:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5Jy/kbnjlImQAmn+YeQNh1yJRiNgE6qD3YiC84ax7f4=;
        b=GHdvw6OIsVDpf3Siac7l89mRwn1LHqHqBQCXbpIVFS/wZ4GiLCujH3aawJ//bJKmVk
         aSseiUYa9651Dzrzxa7SCZ6PrW94qIMitrS0J5+tY4zTsUO2YMVIjz113QtxheG8460s
         4KEEwFckamrU1oagTHPY9SLoT7ooguve5QrmLhZjLa4jVBYMiraTxT5+3ZjB+bRIl8gu
         egAd5GJWWNibdeUsXrRT3KtWDW9AV6dadGZlszf7Pt/6oD8PyOjoaUj8Zv8nfldHYq8W
         sMr00CYJ6Us73Zoc5ZgDeYS0BGMVuMI2okMH0ViyxtCAzRXOkX7MCyyiQZMNmwQHczs5
         3QZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5Jy/kbnjlImQAmn+YeQNh1yJRiNgE6qD3YiC84ax7f4=;
        b=I2p1CDO1eNVLv7jfN3VeluRjsZAOGQmiIWH4XmW35+L1+8HRw3vKvKE8nO3Zs8krbT
         teNdTxAPvOBo3VdXMjVbIMAeWy/iUYZsm/Q0t906WC2uw7JFR6hvIUrboFzq7viEf+6Y
         atQ0i4BJoE2dtJwTUzA54tIbe0Nj/GuSwPplEnZeBoWMGwNlN45vUVqRXniFskkXAZ0m
         ylhi2e+x1HFJwWUmGZmoLRw1vGLzXHXGysg1i1L/ycWK3kZQrUN3pnKX68yqiSG7FoRp
         AiABkGvBpOkdawv5q7HppOo45fVUj1GXT0Zr2GvYWbFM48eY0YUKTq74gozWglgGJxIi
         zriQ==
X-Gm-Message-State: AD7BkJL0gq+fMtxzhI6QUC4CGPLkHtg4+TD99QoINeaWPhhC3tD4hK8+gAAVyQznOaTq2wo0VjWKYviibpnk+g==
X-Received: by 10.194.58.169 with SMTP id s9mr11262935wjq.52.1458234018161;
 Thu, 17 Mar 2016 10:00:18 -0700 (PDT)
Received: by 10.194.110.168 with HTTP; Thu, 17 Mar 2016 10:00:03 -0700 (PDT)
In-Reply-To: <20160317111136.GA21745@lanh>
X-Google-Sender-Auth: QyoCEpYaJ28eJQuHunL6IOpCXPQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289129>

On 17 March 2016 at 11:11, Duy Nguyen <pclouds@gmail.com> wrote:
> Git's top directory is crowded and I think it's agreed that moving
> test-* to t/helper is a good move. I just wanted to check if we could
> take this opportunity (after v2.8.0) to move some other files too. I
> propose the following new subdirs

I wonder whether previous discussions on this still count?  See:

http://marc.info/?l=git&m=129650572621523&w=1

-- Thomas Adam
