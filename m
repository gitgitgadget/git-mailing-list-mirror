From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 8/8] one ugly test to verify basic functionality
Date: Fri, 5 Feb 2016 14:20:38 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602051417490.2964@virtualbox>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com> <1454662677-15137-9-git-send-email-pclouds@gmail.com> <CA+EOSBnZVuHThXLg9+VftPVaKy5wqqxp=iQtP1ZUtxkKq32HMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 14:20:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRgJa-00037B-Io
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 14:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbcBENUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 08:20:42 -0500
Received: from mout.gmx.net ([212.227.17.21]:61008 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165AbcBENUl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 08:20:41 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LswqM-1a3wM90F6w-012c8l; Fri, 05 Feb 2016 14:20:39
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CA+EOSBnZVuHThXLg9+VftPVaKy5wqqxp=iQtP1ZUtxkKq32HMQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:+xYufzSfQAYYa6+6BDiyXtUPDXhhT5Vw7CXzkYIbTVAaFjNGFYC
 Te5hP76AiMz5iO0niLuxmRVR9DGwi2D+Hb8M933SQ5k5KPJ1XNXfZLbQA7iitJS4PtmmCyG
 WAnzz9ZHaHLtWHJIo10g0MpIhNZkCI0SWEvrggBEFj3eThakQLJNxOverIEP1dHGayShEFC
 GXPJGQS2kCWR7rJonPVBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WFGCkP3Zt9Y=:HZQiDCkZ5pVCxClVU4qs3I
 dKZF7u77VaKNQyieSGEZouyEoD+PF9P5t46fxgyXGXZy8n/vpUsl+T2mYW/YlCgTSXSDC0Ng5
 eRLKSMQmSrcdc8/mi9FAPdCfkEkfA1OiXtBCYEkTjitfrYyStcbzQTKZobAWgbrj8GsuoAfPo
 KLcuhEwMNTmV4czXJeEaA0VI8yjryW1xuet5tLFqaMMZLEgDzwzIUN5C1/8+wBJ4usdSJ5zQS
 SOOuJPVCSj5rzLCdjbv9hFJSfWCpcsIMz/v0MD5m+mxuUDY61mzV6gKqvQOZxAG7LM4e1AQv9
 0HhaCW1JhxmxAQ40R+2SKypBlLH6mWBujsxEdee99VfnWhVK54UxJVQwLyVyVkOTL9mY7kneX
 ZJA9amvfN/pb4ItxeybLuD442VrpYAharCAiiGrsp4YydLAKeBhBn82SNECLf83o/qV0saMEX
 wlMSBxe2nOU4b34zygE1UxOddGfPQ6PRvluu5f5VnzL1S22koC/OoV0A0tPjE9r2lXV9Stopb
 aNpZbYrXR1rwKD7sSORVDm3Nr+uEuH6bopVE+4JaqMoxl/EsIAbQCD8A9dNmKbXWo6ADj9LsI
 kqBsBUjb15xii9xIjZMY+Me8ketxh66V9XBwzSAcCjaWrM94bhs67H+wjrI6YE4L8ExumDZef
 YXw6+JTtqwtGKwazuVYQtszRoMftwJrFMQeK4L+bi4040Rua6n3YLnBiXEOO4uUBqvKh9ea2m
 7VCWOMPDiwY43A6ZeJ1fFQRnFM5JEFb+o8AcIbKSpr5Z9uWUkG9nBjkXdprVtTvpJwzzZjhC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285576>

Hi Elia,

On Fri, 5 Feb 2016, Elia Pinto wrote:

> From the git coding guideline : "We prefer $( ... ) for command
> substitution; unlike ``, it properly nests.  It should have been the way
> Bourne spelled it from day one, but unfortunately isn't."

There was only one time in my life as a developer when I had to change a
$(...) to a `...` construct. I do not really remember all the details, but
I think it was on MacOSX, and it was inside a case ... esac and the
closing parentheses was mistaken for a case arm (the $(...) construct
might have been multi-line, is the only thing that would make sense in my
mind.

Did you hear of similar problems?

Ciao,
Dscho
