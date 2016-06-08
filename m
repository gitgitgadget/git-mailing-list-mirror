From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 3/4] dir: introduce file_size() to check the size of file
Date: Wed, 8 Jun 2016 10:17:30 +0200
Message-ID: <5757D49A.304@web.de>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-3-pranit.bauva@gmail.com>
 <CAPig+cTgnp3tm_S7ybDBiGfesw9mh3J4_OtEV7timnsgL0AGjA@mail.gmail.com>
 <CAFZEwPPWMdOahMP4f0=Lm_n+ZmEtGHg=zHaZAyQjSf9oL8X2ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 10:17:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAYgV-0008JZ-9s
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 10:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216AbcFHIRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 04:17:45 -0400
Received: from mout.web.de ([212.227.15.4]:54541 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756062AbcFHIRm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 04:17:42 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MgwSG-1aoTS13Cc4-00M4v2; Wed, 08 Jun 2016 10:17:33
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <CAFZEwPPWMdOahMP4f0=Lm_n+ZmEtGHg=zHaZAyQjSf9oL8X2ew@mail.gmail.com>
X-Provags-ID: V03:K0:UM9ywJOwz6WgzQlRH2RQX04qoGmwZ4Uw60FHm605PrQ0En9NYEl
 8uJegSAZUR9oneteZMr8/fEIg+x5UPzlQn+8TJhYKqwdIXAvcLMBnis5NZPLhv4Ey3n78vi
 f++iY4LYeOKFjJSzJ9mwa68pfdxlZS6fIpUkMJ0ipVh2I88psVAEOxC8bC2nhO6KmG+y5JX
 sEjBTLZAjb6SLaU/W00zg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+/V2B1PE40w=:nwJeEmrwZCiZlFgIgMB9kV
 YZGbOfOIUnvStdNgzP/PQhXyTP6F68LeOOfKcpKDnhCtjUt2n2CCKeZc85BVBq787fN7Yhmn6
 dtBVxJkzNbsaHanb7rijb+Gdwklp3zgAFjp2syeVycIzcnsuOVfWB1hauU8qrDg1rPwE1mzdW
 Mg+sryO51MqS3I+94asiNGZIv5bCVWDMrbKX9LBbhuAybdNof5UaTwLSNiJCbChJP+uC2PbMH
 qYD2n4TdYPmEoo1OXqpQju58h6I7dlxUyOtx/7FBhDHjdAiztXeZdk0U5l/X5Vlwc6ZiiRNiB
 5eJfAt1yc3nocY1g0JEo7Netqgop8mSWRW0oQRETZtbf1IK41Xi3ClTEYWC5nPR7yyrUXfL5j
 Wr5uIy7MKhvXJAmvBkM6n4MrXRJ/bYFsTqBRQfqSFW63RLTYjRU2IlFOQh0QK9VRGpZPhdlb0
 y5OlROxvhttMUrR6dzjEF5tf9DSGisPUFKI8q5pHV0MJ9C1jJSA4vRHZwqM+m0CYlUwCjsWuq
 RsvjFpCiCNiXVVx/P23EtjWwZCybt+MHmqEHXtKaB0KNvaEQwinHOVuuC5i0F7BWyusJ3fauq
 MmfMAGVm0B9yPUpOdRkW6dLROqDQRxBPFCC8+16ZqIgh+LwBIgIKqcZ/036KRKJheJkhm4UoE
 tXYzcqLAoYgytlembSSJpGFZoI0CBIHH+XEm8rZ10VRLSb/tyRR/DbPI9c+Nfktu7vG/6XlAh
 l8mo75WwlxelcAuVDzOCtPXStELVOyRYBsgkkotoqEvThiJBNqjeWfGnqem9m0vd6K0EigQk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296770>

On 06/08/2016 09:57 AM, Pranit Bauva wrote:
> Hey Eric,
>
> On Wed, Jun 8, 2016 at 1:07 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> dir: introduce file_size() to check the size of file
>>>
>>> At times we require to see if the file is empty and get the size of the
>>> file. By using stat we can get the file size without actually having to
>>> open the file to check for its contents.
>> The sole caller of this function in patch 4/4 does so only to check if
>> the file exists; it doesn't even care about the file's size, thus
>> neither this function nor this patch seem justified and probably ought
>> to be dropped unless some better and stronger justification can be
>> shown.
> Umm, actually there is a subtle difference between file_exists() and
> file_size(). file_exists() *only* checks whether the file exists or
> not while file_size() can also be used to check whether the file is
> empty or not also see the implementation of both of them which shows
> the difference. In fact it doesn't care at all about the file size.
> Now there are a lot of instances in shell scripts where there are
> quite some differences with -f and -s and some places *do care* about
> this subtle difference. For eg. in bisect_reset() we test whether the
> file .git/BISECT_START has some contents in it. But I guess I can add
> some more justification in the commit message. What do you think?
>
>>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>> ---
>>> diff --git a/dir.c b/dir.c
>>> @@ -2036,6 +2036,14 @@ int file_exists(const char *f)
>>> +ssize_t file_size(const char *filename)
>>> +{
>>> +       struct stat st;
>>> +       if (stat(filename, &st) < 0)
>>> +               return -1;
>>> +       return xsize_t(st.st_size);
>>> +}
>>> +
>>> diff --git a/dir.h b/dir.h
>>> @@ -248,6 +248,13 @@ extern void clear_exclude_list(struct exclude_list *el);
>>> +/*
>>> + * Return the size of the file `filename`. It returns -1 if error
>>> + * occurred, 0 if file is empty and a positive number denoting the size
>>> + * of the file.
>>> + */
>>> +extern ssize_t file_size(const char *);
>
So what I understand, you want something like this:

+ssize_t file_size_not_zero(const char *filename)
+{
+       struct stat st;
+       if (stat(filename, &st) < 0)
+               return -1;
+       return !!st.st_size);
+}
