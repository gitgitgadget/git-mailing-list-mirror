From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Installing on AIX fails
Date: Fri, 4 Jun 2010 11:17:18 +0200
Message-ID: <AANLkTik5zd_X9rddiuKQ_qGwXYLluRxl-SSKGNgol4yc@mail.gmail.com>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
	<AANLkTik_FI0CETWZZcu8O8MQQx5oV6YAbt5-X0ozbVmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 11:17:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKT1o-00007N-36
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 11:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951Ab0FDJRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 05:17:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33802 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab0FDJRU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 05:17:20 -0400
Received: by fxm8 with SMTP id 8so630884fxm.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=Imu8lhQ5LgjZGxEYJ6idfqpOPl8aRFmu+hZytY70Jc4=;
        b=H0Fe5X7+UujvvsI9zh0OOzIQt3kuWXP2DsiltQy/x6RbSZAbP/0bpPkX1fq814IrfV
         E7OBKURSDUS+wfXxiwEX8XNyhZ7yFBKLDNBsVj7mwyHUeZbI8QbtdF17qpAhY4VCUJHp
         6yL9OYQ8gTE88SAxT6vz3bn6HFuCqfZnUr7jc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=q/l0v8ULdIi6vSJ2QdtXyfU1HVWx07guyr0xxE+73kzW3O6uzPJ7a3FrRqRtQsJaHr
         HLUcL5p/xb2w6jJr7KhfJze5TSr8HH6n2MTlEl6ELUGU01dD7NlNDxpal3D3H5C+a5+Z
         OtKvlaOSRd9iBrPcu5GYOKGC+tIMWuH/rVvVM=
Received: by 10.239.184.197 with SMTP id z5mr721630hbg.0.1275643038477; Fri, 
	04 Jun 2010 02:17:18 -0700 (PDT)
Received: by 10.239.156.209 with HTTP; Fri, 4 Jun 2010 02:17:18 -0700 (PDT)
In-Reply-To: <AANLkTik_FI0CETWZZcu8O8MQQx5oV6YAbt5-X0ozbVmw@mail.gmail.com>
X-Google-Sender-Auth: MYZjPV6DT3D4o4C43ve4nI1-9wU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148391>

On Fri, Jun 4, 2010 at 11:13, Tor Arntsen <tor@spacetec.no> wrote:

> The only problem now is that some stuff (git rebase --interactive
> IIRC) will still not work, if you're on an AIX version with Perl 5.6
> (some things in git needs 5.8).

Thinking harder I now believe it was 'git add --patch' which needs Perl >= 5.8.

-Tor
