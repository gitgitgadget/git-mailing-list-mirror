From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: long fast-import errors out "failed to apply delta"
Date: Tue, 26 Jul 2011 20:55:04 +0200
Message-ID: <20110726185504.GA2398@elie.dc0b.debconf.org>
References: <CA+gfSn8jjptyv10iVimmfXpf6QHrR_3UpkRdd+Dv1M=KgORtGQ@mail.gmail.com>
 <CA+gfSn8C-nB2hSSRTqSu1N1Z-b8ctRsVmUGAjLXTW0du_W3EQw@mail.gmail.com>
 <CA+gfSn8m=_vd91Xe5EnFXUvZnuJf-yUE6H7FU+ak8S8a+NtCjA@mail.gmail.com>
 <20110726165858.GA2334@elie.dc0b.debconf.org>
 <CA+gfSn-ZhqXfTELg_LfMJhMW7L7GVBoRTwZO_+QYntLrh+rk0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 20:55:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlmmn-0004OK-Qn
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 20:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369Ab1GZSzR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 14:55:17 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34647 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab1GZSzP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2011 14:55:15 -0400
Received: by ewy4 with SMTP id 4so673047ewy.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 11:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q1yH3E7Kr9sOAdUA5rxAKsbRKTruP2ef18yUHGLLvnk=;
        b=Lez0JJJMY4vbJ2xrXXPNtHuxYKXHZ/drxY11pkZ1/PG70gcsuYav2+ejGR8noHDrXe
         RKXKV7eUIrlxZay4lfswPpNEAgLeDbV+7IWQpJGwiFsekhhC7ggpNom0R2aZM5La7jdF
         7xgLc4uGCkhssuJXkrorbnF0LHakRgV1hfkgI=
Received: by 10.14.1.67 with SMTP id 43mr2454762eec.43.1311706513522;
        Tue, 26 Jul 2011 11:55:13 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id x9sm555356eem.63.2011.07.26.11.55.11
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 11:55:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+gfSn-ZhqXfTELg_LfMJhMW7L7GVBoRTwZO_+QYntLrh+rk0Q@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177897>

Dmitry Ivankov wrote:
> On Tue, Jul 26, 2011 at 10:58 PM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:

>> Could you save the svn-fe output (e.g., by introducing "tee" in the
>> middle of the "svn-fe | fast-import" pipeline) and put it up
>> somewhere online? =C2=A0This would also be a good starting point for=
 coming
>> up with a reduced testcase.
>
> It's 1.9G uncompressed, 0.7G lzo-compressed. Will setup a ftp or
> torrent seed a bit later.

Ah, never mind then. :)  Do you have a script to reproduce it?
