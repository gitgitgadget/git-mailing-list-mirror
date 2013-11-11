From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Mon, 11 Nov 2013 09:03:43 -0800
Message-ID: <20131111170343.GK10302@google.com>
References: <CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>
 <xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>
 <1839883487.4893076.1383646619137.JavaMail.root@imag.fr>
 <xmqqk3gl8id0.fsf@gitster.dls.corp.google.com>
 <vpq1u2tb3px.fsf@anie.imag.fr>
 <20131106234544.GF10302@google.com>
 <vpqtxfo8ow4.fsf@anie.imag.fr>
 <xmqqli0yojp8.fsf@gitster.dls.corp.google.com>
 <527D6805.3050303@xiplink.com>
 <xmqqob5qna7b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Greg Jacobson <coder5000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 18:03:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfuty-0001AF-Oq
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 18:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497Ab3KKRDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 12:03:47 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:44810 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984Ab3KKRDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 12:03:46 -0500
Received: by mail-pd0-f171.google.com with SMTP id w10so5421453pde.30
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 09:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hwqGUbMCO3GyckOsHN72CF6s5HvYEuEwJO7XvylCXxc=;
        b=aAV+1EnJVSv1P2uPgN1IKD5gsXhGcWiehs346IveqoCiReAZVDcNIyK/swgHuGP6m+
         AJEq3oNK9IpvPubI4v0JlswSnHx1/XzhOcBd3RsYpCO2ikqIB0DEKYAUAsOxRUHwNeYG
         6axKqgBgnPXHIbjqzlsH8ez2SSkN5Gt4G7owBCJw33l0d3d6EnbVVQv1CZLumWLV+EHr
         BoFWCfpom5ZpCDSjfu+aR99ngQuwZJ5MS4SiU8nq+TgDsDzn8F8H8gMf+VOxFEmewqWv
         6t7J9hfwYo8AcWF7FPK6lkOVI3Cf6xburHqDauHWwG5+TcHwkmOdpq9h2mZ4hQs3Hc8e
         11HQ==
X-Received: by 10.67.1.203 with SMTP id bi11mr7538129pad.137.1384189425563;
        Mon, 11 Nov 2013 09:03:45 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ry3sm4807792pbc.8.2013.11.11.09.03.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 Nov 2013 09:03:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqob5qna7b.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237618>

Junio C Hamano wrote:

> Is everybody happy with this version?

Looks good to me.

Thanks,
Jonathan
