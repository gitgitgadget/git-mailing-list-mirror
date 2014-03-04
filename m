From: karthik nayak <karthik.188@gmail.com>
Subject: Re: git compile with debug symbols
Date: Tue, 4 Mar 2014 21:30:38 +0530
Message-ID: <CAOLa=ZRAtOkLAQS89G59=KHvCvuBQ_ptU1ACSqh==ww29-7NKg@mail.gmail.com>
References: <1393947964.16150.YahooMailNeo@web162902.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Mahesh Pujari <pujarimahesh_kumar@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:01:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKrmJ-00014u-BR
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 17:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbaCDQBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 11:01:06 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:51119 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbaCDQBE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 11:01:04 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so1517530pad.0
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 08:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=C4xuMPGLbVARrJ16h5GEqra1cS9ig2+IJCPE7OYzHME=;
        b=mnBXcgzXGmqYrwkcOu1ZVDpj9JoIE6mbPcaYgxoDJPsTlv1mkJRLD+nUR51SJYJj/e
         3gxcRXcunxfkKTSR5ujKWG/k4Am85bmIbZEpSOfGb/nPIQCtta4nUTvJ0y3ZS704+2X4
         8Che2xLsaA8IdtvOxtI+6gEauyl+s65A4uQAVXWwiGpx7eCxzphBxK1aks2F8CJDqhxl
         tTRaBvlsZa56vylZipmSYW8IlKCtEDK3XWqyJTCoHlbcwgXbPAzEaXdNvfsvvJVdH+lB
         i0qla2MN6UYyWEbC7a9N5O+coFz2t6J7CpiOe1otjhLh13vq3yjc0/slryTzrgcUZ3ga
         9Iiw==
X-Received: by 10.68.143.196 with SMTP id sg4mr127941pbb.155.1393948858495;
 Tue, 04 Mar 2014 08:00:58 -0800 (PST)
Received: by 10.68.138.138 with HTTP; Tue, 4 Mar 2014 08:00:38 -0800 (PST)
In-Reply-To: <1393947964.16150.YahooMailNeo@web162902.mail.bf1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243352>

A quick look at the Makefile shows that -g is enabled by default. so
debugging is enabled by default

On Tue, Mar 4, 2014 at 9:16 PM, Mahesh Pujari
<pujarimahesh_kumar@yahoo.com> wrote:
>
>
> Hello,
>  I am trying to compile git with debug symbols and failed to do so (basically I am a noob), can some one direct me to links or mailing list (have searched but couldn't find) or doc's so that I can debug git using gdb.
>
> thanks,
> mpujari
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
